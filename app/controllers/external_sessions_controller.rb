class ExternalSessionsController < ApplicationController

  def new
    @external = ExternalUser.new
  end

  def create
    @external = ExternalUser.find_by(username: params[:external_user][:username])

    if @external && @external.authenticate(params[:external_user][:password])
      session[:external_user_id] = @external.id
      session[:inhouse_user_id] = nil
      flash[:notice] = "You have logged in as #{@external.username}"
      redirect_to ext_mainpage_path
    else
      @external = ExternalUser.new
      @external.errors[:base] << "Username / password is invalid"
      render :new
    end
  end

  def destroy

  end

end