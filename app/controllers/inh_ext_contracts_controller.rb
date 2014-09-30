class InhExtContractsController < ApplicationController

  def inh_index
    @externals = ExternalUser.all
  end

  def ext_index

  end

  def search_for_ext
    @externals = ExternalUser.all
  end

  def inh_create
    @contract = InhExtContract.new(ext_user_id: params["id"], inh_user_id: current_inhouse_user.id)
  end

end