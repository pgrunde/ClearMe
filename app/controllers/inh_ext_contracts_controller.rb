class InhExtContractsController < ApplicationController

  def inh_index
    @externals = ExternalUser.all
  end

  def ext_index
    @inhouse = InhouseUser.joins(:inh_ext_contracts).where("inh_ext_contracts.ext_accepted = false")
  end

  def search_for_ext
    # @externals = ExternalUser.joins(:inh_ext_contracts).where.not(inh_user_id: current_inhouse_user.id)
    # @externals = ExternalUser.joins('INNER JOIN "inh_ext_contracts" ON "external_users"."id" <> "inh_ext_contracts"."ext_user_id"')
    @externals = ExternalUser.includes(:inh_ext_contracts).select {|eu| !has_contract?(eu) }
  end

  def inh_create
    @contract = InhExtContract.new(ext_user_id: params["id"],
                                   inh_user_id: current_inhouse_user.id,
                                   inh_accepted:false,
                                   ext_accepted:false)
    if @contract.save
      flash[:notice] = "A request for a contract has been sent."
      redirect_to search_for_ext_path
    else
      flash[:notice] = "You have already request a contract from that recruiter."
      redirect_to search_for_ext_path
    end
  end

  def ext_send_contract
    @contract = InhExtContract.find_by(inh_user_id: params["id"].to_i, ext_user_id: current_external_user.id)
    @contract.ext_accepted = true
    @contract.save
    redirect_to external_contracts_path
  end

  def inh_approve_contract
    @contract = InhExtContract.find_by(ext_user_id: params["id"], inh_user_id: current_inhouse_user.id)
    @contract.inh_accepted = true
    @contract.save
    redirect_to view_pending_contracts_path
  end

  def view_pending_contracts
    @externals = ExternalUser.joins(:inh_ext_contracts).where("inh_ext_contracts.ext_accepted = true AND inh_ext_contracts.inh_accepted = false")
  end

  private

  def has_contract?(external_user)
    external_user.inh_ext_contracts.any? { |c| c.inh_user_id == current_inhouse_user.id }
  end

end