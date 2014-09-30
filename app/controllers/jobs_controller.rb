class JobsController < ApplicationController
  def index
    # @jobs = Job.where(inh_user_id: current_inhouse_user.id)
    @jobs = Job.all
    p @jobs
  end

  def new
    @job = Job.new
    @user_forms = Form.where(inh_user_id: current_inhouse_user.id)
  end

  def show

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

  end

  def destroy

  end

  private

  def allowed_params
    params.require(:job).permit(:title, :description, :location, :form_id).merge(
                                inh_user_id: current_inhouse_user.id)
  end
end