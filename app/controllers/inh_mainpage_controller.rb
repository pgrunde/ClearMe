class InhMainpageController < ApplicationController

  before_filter :ensure_authed_inhouse_user

  def show
    @inhouse = InhouseUser.find_by(id: session[:inhouse_user_id])
  end
end