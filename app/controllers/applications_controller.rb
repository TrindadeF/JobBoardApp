class ApplicationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @job = Job.find(params[:job_id])
    @application = Application.new
  end

  def create
    @job = Job.find(params[:job_id])
    @application = @job.applications.build(application_params)
    @application.user = current_user

    if @application.save
      redirect_to job_path(@job), notice: 'Aplicação enviada com sucesso.'
    else
      render :new
    end
  end

  def destroy
    @application = current_user.applications.find(params[:id])
    @application.destroy
    redirect_to my_applications_path, notice: 'Você desistiu da vaga com sucesso.'
  end

  private

  def application_params
    params.require(:application).permit(:name, :email, :resume)
  end
  
end
