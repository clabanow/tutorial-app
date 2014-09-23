class TracksController < ApplicationController

  def index
    @title = "All tracks"
    @tracks = Track.paginate(page: params[:page])
  end

  def new
    @title = "Add a track"
    @track = Track.new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      flash[:success] = "New track created"
      redirect_to @track
    else
      render 'new'
    end
  end

  def show
    @track = Track.find(params[:id])
    @title = @track.name
  end

  def edit 
    @title = "Edit track"
    @track = Track.find(params[:id])
  end

  def update
    if @track.update_attributes(track_params)
      flash[:success] = "Track successfully edited"
      redirect_to @track
    else
      render 'edit'
    end
  end

  def destroy
    Track.find(params[:id])
    flash[:success] = "Track successfully deleted"
    redirect_to tracks_url
  end

  private

  def track_params
    params.require(:track).permit(:name)
  end
end
