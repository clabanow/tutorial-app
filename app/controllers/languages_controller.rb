class LanguagesController < ApplicationController

  def index
    @title = "All languages"
    @languages = Language.paginate(page: params[:page])
  end

  def new
    @title = "Add a language"
    @language = Language.new
  end

  def create
    @language = Language.new(language_params)
    if @language.save
      flash[:success] = "New language added"
      redirect_to languages_path
    else
      render 'new'
    end
  end

  def show
    @language = Language.find(params[:id])
    @title = @language.name
  end

  def edit
    @title = "Edit language"
    @language = Language.find(params[:id])
  end

  def update
    @language = Language.find(params[:id])
    if @language.update_attributes(language_params)
      flash[:success] = "Language edited"
      redirect_to languages_path
    else
      render 'edit'
    end
  end

  def destroy
    Language.find(params[:id]).destroy
    flash[:success] = "Language deleted"
    redirect_to languages_path
  end

  private

    def language_params
      params.require(:language).permit(:name)
    end

end
