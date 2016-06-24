class FavouritesController < ApplicationController
  def index
  end

  def create
    @project = Project.find params[:project_id]
    f = Favourite.new(project: @project, user: current_user)
    if @project.user != current_user
      if f.save
        redirect_to project_path(@project), notice: "Favourite project added!"
      else
        redirect_to project_path(@project), notice: "Failed"
      end
    else
      redirect_to project_path(@project), notice: "You can't favourite your own project!"
    end
  end

  def destroy
    @project = Project.find params[:project_id]
    @favourite = Favourite.find params[:id]
    @favourite.destroy if can? :destroy, Favourite
    redirect_to project_path(@project), notice: "Favourite removed!"
  end
end
