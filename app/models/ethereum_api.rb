class EthereumApi
  TRUFFLE_PATH = "#{Dir.pwd}/truffle/"
  GANACHE_URL = 'HTTP://127.0.0.1:7545'
  attr_accessor :contract, :client

  def initialize
    @client = Ethereum::HttpClient.new(GANACHE_URL)
    create_default_token! if Token.count.zero?
    token = Token.first
    @contract = Ethereum::Contract.create(name: "AppToken", truffle: { paths: [ TRUFFLE_PATH ] }, client: @client, address: token.token_address)
  end

  def create_default_token!
    @client = Ethereum::HttpClient.new(GANACHE_URL)
    @contract = Ethereum::Contract.create(name: "AppToken", truffle: { paths: [ TRUFFLE_PATH ] }, client: @client)
    token = Token.new(
      name: Token::DEFAULT_NAME,
      symbol: Token::DEFAULT_SYMBOL,
      total_supply: Token::DEFAULT_TOTAL_SUPPLY
    )
    address = @contract.deploy_and_wait(token.name, token.symbol, token.total_supply)
    token.token_address = address
    token.save!
  end

  def get_accounts
    @client.eth_accounts['result']
  end

  def transfer(address, amount)
    begin
      @contract.transact_and_wait.transfer(address, amount)
    rescue => e
      Rails::logger::debug("Error token transfer. message: #{e.message}")
      false
    end
  end
end
