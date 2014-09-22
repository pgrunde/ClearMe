class InhouseUsersController < ApplicationController

  # skip_before_filter :ensure_authed_external_user
  # skip_before_filter :ensure_authed_inhouse_user

  def new
    @inhouse = InhouseUser.new
  end

  def create
    @inhouse = InhouseUser.new(
      username: params[:inhouse_user][:username],
      email: params[:inhouse_user][:email],
      password: params[:inhouse_user][:password]
    )

    if @inhouse.save
      flash[:notice] = "Thanks for registering as an Inhouse Recruiter!"
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy

  end

end