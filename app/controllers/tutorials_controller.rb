class TutorialsController < ApplicationController

  def new 
    @title = "Add a tutorial"
    @tutorial = Tutorial.new
  end

  def create
    @tutorial = Tutorial.new(tutorial_params)
    if @tutorial.save
      flash[:success] = "New tutorial created"
      redirect_to 'tutorials_path'
    else
      render 'new'
    end
  end

  def index
    @title = "All tutorials"
    @users = User.paginate(page: params[:page])
  end
end
