class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy, :show_applications]
  before_action :authenticate_user!

  def all_jobs
    @jobs = Job.all
  end
  
  def index
    @jobs = Job.all
  end

  def show
    @application = current_user.applications.find_by(job: @job) || current_user.applications.new
  end

  def new
    @job = Job.new
  end

  def edit

  end

  def apply
    @job = Job.find(params[:job_id])
    @application = @job.applications.new(user: current_user)

    if @application.save
      flash[:notice] = 'Aplicação realizada com sucesso!'
      redirect_to @job
    else
      flash[:alert] = 'Não foi possível aplicar para esta vaga.'
      render :show
    end
  end

  def my_applications
    @applications = current_user.applications
  end

  def job_params
    params.require(:job).permit(:title, :description, :company, :location, :salary)
  end

  def create
    @job = Job.new(job_params)
    @job.recruiter = current_user

    if @job.save
      redirect_to @job, notice: 'Vaga criada com sucesso.'
    else
      render :new
    end
  end
  
  def search
    @query = params[:query]
    @jobs = Job.where("title LIKE ?", "%#{@query}%")
  end

  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :requirements, :education, :location)
  end

end
