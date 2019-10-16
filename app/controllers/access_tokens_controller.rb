class AccessTokensController < ApplicationController

  def create
    authenticator = UserAuthenticator.new(params[:code])
    authenticator.perform

    render json: authenticator.access_token, status: :created
  end

  def destroy
    #solve this the json is empty(nil) but should be proper error
    render json: {}, status: :forbidden
  end

end
