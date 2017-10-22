class TracksController < ApplicationController
  def show
    sampler = Sampler.find_or_create_by(id: 1, user_id: 1, title: "Test")
    spotify_user = RSpotify::User.find(session[:user_id])
    playlist = spotify_user.playlists.last
    track = playlist.tracks[0]
    @track = Track.create(name: track.name, artist: track.artists[0].name, album: track.album.name, preview_url: track.preview_url, image: track.album.images[0]["url"], sampler_id: 1)
  end

  def update
    @track = Track.find(params[:id])
    @track.update(params[:track].permit(:image))
    redirect_to "/samplers/new?id=#{params[:playlist_id]}"
  end
end
