class ExtMainpageController < ApplicationController
  def show
    @external = ExternalUser.find_by(id: session[:external_user_id])
  end
end