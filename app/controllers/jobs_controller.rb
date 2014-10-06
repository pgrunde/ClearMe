class JobsController < ApplicationController


  def index
    @jobs = Job.where(inh_user_id: current_inhouse_user.id)
  end

  def ext_index
    @jobs = ExternalUser.find_by(id: current_external_user.id).inhouse_users.where("inh_ext_contracts.ext_accepted = true AND inh_ext_contracts.inh_accepted = true").map {|inh| inh.jobs}.flatten
  end

  def new
    @job = Job.new
    @user_forms = Form.where(inh_user_id: current_inhouse_user.id)
  end

  def edit
    @job = Job.find_by(id: params["id"])
    @user_forms = Form.where(inh_user_id: current_inhouse_user.id)
  end

  def create
    @job = Job.new(allowed_params)

    if @job.save
      redirect_to jobs_path
    else
      render :new
    end
  end

  def update
    job = Job.find_by(id:params["id"])
    if job
      job.title = params["job"]["title"]
      job.description = params["job"]["description"]
      job.location = params["job"]["location"]
      job.form_id = params["job"]["form_id"]
      job.save
    end
    redirect_to jobs_path
  end

  def destroy
    job = Job.find_by(id: params["id"])
    job.destroy
    redirect_to jobs_path
  end

  private

  def allowed_params
    params.require(:job).permit(:title, :description, :location, :form_id).merge(
                                inh_user_id: current_inhouse_user.id)
  end
end