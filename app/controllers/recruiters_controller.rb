class RecruitersController < ApplicationController
  def dashboard
    @jobs = current_user.jobs.all
    @job = Job.new  
  end

  def show_applications
    @job = Job.find(params[:id])  
    @applications = @job.applications
  end


  def update_status
    @application = Application.find_by(id: params[:id])
  
    if @application
      if @application.update(status_params)
        redirect_to recruiter_dashboard_path, notice: 'Status atualizado com sucesso.'
      else
        redirect_to recruiter_dashboard_path, alert: 'Não foi possível atualizar o status.'
      end
    else
      redirect_to recruiter_dashboard_path, alert: 'Aplicação não encontrada.'
    end
  end
  
  private
  
  def status_params
    params.require(:application).permit(:status) 
  end
end
