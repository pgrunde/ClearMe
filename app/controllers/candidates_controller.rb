class CandidatesController < ApplicationController

  def ext_index
    @candidates = Candidate.where(external_user_id: current_external_user.id)
  end

  def ext_all
    @candidates = Candidate.where(external_user_id: current_external_user.id)
  end

  def ext_create
    @candidate = Candidate.new(allowed_params)
    @candidate.external_user_id = current_external_user.id
    @candidate.state = "active"

    if @candidate.save
      flash[:notice] = "Candidate Created"
      redirect_to ext_candidate_mgmt_path
    else
      render :ext_new
    end
  end

  def ext_new
    @candidate = Candidate.new
  end

  def ext_submit_candidate
    @job = Job.find_by(id: params[:id])
    @candidates = Candidate.where(external_user_id: current_external_user.id)
    gon.formdata = Form.find_by(id: @job.form_id)
  end

  private

  def allowed_params
    params.require(:candidate).permit(:first_name, :last_name, :title, :bio)
  end

end