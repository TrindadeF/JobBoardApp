class ApplicationsController < ApplicationController
  def new
    @job = Job.find(params[:job_id])
    @application = Application.new
  end

  def create
    if @job
      @application = @job.applications.build(application_params)
      @application.user_id = current_user.id

      if @application.save
        redirect_to dashboard_path, notice: 'Aplicação enviada com sucesso!'
      else
        render :new
      end
    else
      redirect_to root_path, alert: 'Job não encontrado.'
    end
  end
  private

  def set_job
    @job = Job.find_by(id: params[:job_id])
    unless @job
      redirect_to root_path, alert: 'Job não encontrado.'
    end
  end

  def application_params
    params.require(:application).permit(:name, :email, :resume)
  end
end
