class TransfersController < ApplicationController
  TRUFFLE_PATH = "#{Dir.pwd}/truffle/"
  GANACHE_URL = 'HTTP://127.0.0.1:7545'

  def new
    @address = params[:address]
    @token = Token.first
  end

  def create
    @address = transfer_params[:address]
    amount = transfer_params[:amount]
    @ethereum_api = EthereumApi.new
    if @ethereum_api.transfer(@address, amount.to_i)
      redirect_to root_path, notice: '送金に成功しました。'
    else
      @token = Token.first
      flash[:alert] = '送金に失敗しました。'
      render :new
    end
  end

  private

    def transfer_params
      params.require(:transfer).permit(:address, :amount)
    end
end
