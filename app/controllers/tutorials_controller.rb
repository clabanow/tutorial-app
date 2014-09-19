class TutorialsController < ApplicationController
  

  def new 
    @title = "Add a tutorial"
    @tutorial = Tutorial.new
  end

  def create
    @tutorial = Tutorial.new(tutorial_params)
    if @tutorial.save
      flash[:success] = "New tutorial created"
      redirect_to tutorials_path
    else
      render 'new'
    end
  end

  def index
    @title = "All tutorials"
    @tutorials = Tutorial.paginate(page: params[:page])
  end

  def edit
    @title = 'Edit tutorial'
    @tutorial = Tutorial.find(params[:id])
  end

  def update
    @tutorial = Tutorial.find(params[:id])
    if @tutorial.update_attributes(tutorial_params)
      flash[:success] = "Tutorial edited"
      redirect_to tutorials_path
    else
      render 'edit'
    end
  end

  def destroy
    Tutorial.find(params[:id]).destroy
    flash[:success] = "Tutorial deleted"
    redirect_to tutorials_path
  end

  private

    def tutorial_params
      params.require(:tutorial)
            .permit(
              :title, 
              :url, 
              :description, 
              :publisher_id, 
              :category_id, 
              :media_type_id, 
              :is_paid,
              :date_created
            )
    end

    # before filters

    
end
