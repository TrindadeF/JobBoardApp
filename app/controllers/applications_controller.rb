class ApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_application, only: [:update_status]

  def new
    @job = Job.find(params[:job_id])
    @application = Application.new
  end

  def create
    @job = Job.find(params[:job_id])
    @application = current_user.applications.find_by(job_id: @job.id)
  
    if @application
      flash[:alert] = "Você já aplicou para esta vaga."
      redirect_to job_path(@job)
      return
    end
  
    @application = @job.applications.build(application_params)
    @application.user_id = current_user.id
  
    if @application.save
      flash[:notice] = "Aplicação criada com sucesso."
      redirect_to job_path(@job)
    else
      render 'new'
    end
  end

  def destroy
    @application = Application.find(params[:id])
    @application.destroy
  
    respond_to do |format|
      format.html { redirect_to jobs_path, notice: 'Aplicação desistida com sucesso.' }
      format.json { head :no_content }
    end
  end


  def index
    @applications = @job.applications
  end

  def update_status
    @application = Application.find_by(id: params[:id])
  
    if @application
      if @application.update(status_params)
        redirect_to recruiter_root_path, notice: 'Status atualizado com sucesso.'
      else
        redirect_to recruiter_root_path, alert: 'Não foi possível atualizar o status.'
      end
    else
      redirect_to recruiter_root_path, alert: 'Aplicação não encontrada.'
    end
  end

  private

  def set_job
    @job = Job.find(params[:job_id])
  end

  def set_application
    @application = Application.find(params[:id])
  end

  def application_params
    params.require(:application).permit(:name, :email, :resume)
  end

  def status_params
    params.require(:application).permit(:status)
  end
end
