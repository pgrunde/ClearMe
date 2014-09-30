class ExtMainpageController < ApplicationController

  before_filter :ensure_authed_external_user

  def show
    @external = ExternalUser.find_by(id: session[:external_user_id])
  end
end