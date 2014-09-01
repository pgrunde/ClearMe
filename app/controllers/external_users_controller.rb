class ExternalUsersController < ApplicationController

  def new
    @external = ExternalUser.new
  end

  def create
    @external = ExternalUser.new(
      username: params[:external_user][:username],
      email: params[:external_user][:email],
      password: params[:external_user][:password]
    )

    if @external.save
      flash[:notice] = "Thanks for registering as an External Recruiter!"
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy

  end

end