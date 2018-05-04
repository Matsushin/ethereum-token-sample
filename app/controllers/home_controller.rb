class HomeController < ApplicationController
  TRUFFLE_PATH = "#{Dir.pwd}/truffle/"
  GANACHE_URL = 'HTTP://127.0.0.1:7545'

  def index
    @ethereum_api = EthereumApi.new
  end
end
