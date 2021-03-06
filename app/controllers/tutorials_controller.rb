class TutorialsController < ApplicationController
  
  def index
    @title = "All tutorials"
    @tutorials = Tutorial.paginate(page: params[:page])
  end

  def new 
    @title = "Add a tutorial"
    @tutorial = Tutorial.new
    @media_type_options = media_type_options
    @tags = get_tag_options
  end

  def create
    @tutorial = Tutorial.new(tutorial_params)
    if @tutorial.save
      flash[:success] = "New tutorial created"
      redirect_to tutorials_path
    else
      @media_type_options = media_type_options
      @tags = get_tag_options
      render :new
    end
  end

  def edit
    @title = 'Edit tutorial'
    @tutorial = Tutorial.find(params[:id])
    @media_type_options = media_type_options
    @tags = get_tag_options
    @selected_tags = get_selected_tags
    @selected_primary_topic = @tutorial.primary_topic
  end

  def update
    @tutorial = Tutorial.find(params[:id])
    if @tutorial.update_attributes!(tutorial_params)
      flash[:success] = "Tutorial edited"
      redirect_to tutorials_path
    else
      @media_type_options = media_type_options
      @tags = get_tag_options
      @selected_tags = get_selected_tags
      @selected_primary_topic = @tutorial.primary_topic
      render :edit
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
              :author,
              :media_type, 
              :is_paid,
              :date_created,
              :primary_topic_id,
              :tag_ids
            )
    end

    def media_type_options
      %w[Text Video]
    end

    def get_tag_options
      tags = Tag.all.map(&:name_and_value)
      tags.unshift(['- select one -', nil])
      tags
    end

    def get_selected_tags
      Tutorial.find(params[:id]).tags
    end

    # before filters

    
end
