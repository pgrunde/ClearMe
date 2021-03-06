class FormsController < ApplicationController

  before_filter :ensure_authed_inhouse_user

  def index
    @forms = Form.where(inh_user_id: current_inhouse_user.id)
  end

  def new
    @form = Form.new
  end

  def edit
    @form = Form.find(params[:id])
    gon.formdata = @form
    respond_to do |format|
      format.html
      format.json {render json: @form}
    end

  end

  def create
    form = Form.new(title: params["title"], json: params["json"], inh_user_id: current_inhouse_user.id )
    form.save
    redirect_to forms_path
  end

  def update
    form = Form.find_by(id: params["id"])
    if form
      form.json = params["json"]
      form.title = params["title"]
      form.save
    end

    render :nothing => true
  end

  def destroy
    form = Form.find_by(id: params["id"])
    form.destroy
    redirect_to forms_path
  end

  def fetch_json
    @form = Form.find(params[:id])
    respond_to :json
    if @form
      respond_with(@form)
    end
  end

end