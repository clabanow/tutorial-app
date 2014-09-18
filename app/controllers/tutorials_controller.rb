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
