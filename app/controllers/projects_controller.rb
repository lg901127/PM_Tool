class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  def authenticate_user!
    redirect_to new_session_path, alert: "Please sign in" unless user_signed_in?
  end

  def index
    @projects = Project.order("due_date").paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @project = Project.find params[:id]
    @discussion = Discussion.new
    @task = Task.new
  end

  def new
    @project = Project.new
  end

  def create
    project_params = params.require(:project).permit(:title, :description, :due_date, {tag_ids: []})
    @project = Project.new project_params
    @project.user = current_user
    if @project.save
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def edit
    @project = Project.find params[:id]
  end

  def update
    @project = Project.find params[:id]
    project_params = params.require(:project).permit(:title, :description, :due_date)
    if @project.update project_params
      redirect_to project_path(@project)
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find params[:id]
    @project.destroy
    redirect_to projects_path
  end

end
