class TracksController < ApplicationController

  def update
    @track = Track.find(params[:id])
    @track.update(params[:track].permit(:image))
    redirect_to "/samplers/new?id=#{session[:playlist_id]}"
  end
end
