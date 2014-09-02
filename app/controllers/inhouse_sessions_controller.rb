class InhouseSessionsController < ApplicationController

  def new
    @inhouse = InhouseUser.new
  end

  def create
    @inhouse = InhouseUser.find_by(username: params[:inhouse_user][:username])

    if @inhouse && @inhouse.authenticate(params[:inhouse_user][:password])
      session[:inhouse_user_id] = @inhouse.id
      session[:external_user_id] = nil
      flash[:notice] = "You have logged in as #{@inhouse.username}"
      redirect_to inh_mainpage_path
    else
      @inhouse = InhouseUser.new
      @inhouse.errors[:base] << "Username / password is invalid"
      render :new
    end
  end

  def destroy

  end

end