class InhMainpageController < ApplicationController
  def show
    @inhouse = InhouseUser.find_by(id: session[:inhouse_user_id])
  end
end