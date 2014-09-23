class TagsController < ApplicationController

  def index
    @title = "All tags"
    @tags = Tag.paginate(page: params[:page])
  end

  def new
    @title = "Add a tag"
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:success] = "New tag created"
      redirect_to tags_path
    else
      render 'new'
    end
  end

  def show
    @tag = Tag.find(params[:id])
    @title = @tag.name
  end

  def edit
    @title = "Edit tag"
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update_attributes(tag_params)
      flash[:success] = "Tag successfully edited"
      redirect_to tags_path
    else
      render 'edit'
    end
  end

  def destroy
    Tag.find(params[:id]).destroy
    flash[:success] = "Tag deleted"
    redirect_to tags_path
  end

  private

    def tag_params
      params.require(:tag).permit(:name)
    end

end
