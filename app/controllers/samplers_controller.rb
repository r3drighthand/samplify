class SamplersController < ApplicationController

  def new
    @spotify_user = RSpotify::User.find(session[:user_id])
    @playlists = @spotify_user.playlists
    @playlists.each do |playlist|
      if playlist.id == params[:id]
        @playlist = playlist
      end
    end
    @user = User.find_by(spotify_id: session[:user_id])
    @sampler = Sampler.find_or_create_by(user_id: @user.id, title: @playlist.name, spotify_url: @playlist.external_urls["spotify"], samplified: false)
    session[:playlist_id] = @playlist.id

    if @sampler.tracks.empty?
      @playlist.tracks.each do |track|
        @track = Track.create(name: track.name, artist: track.artists[0].name, album: track.album.name, preview_url: track.preview_url, image: track.album.images[0]["url"], sampler_id: @sampler.id)
      end
    else
      @sampler.tracks.each_with_index do |track, index|
        track.image = @playlist.tracks[index].album.images[0]["url"]
        track.save
      end
    end
    @tracks = @sampler.tracks
  end

  def update
    @sampler = Sampler.find_by(id: params[:id])
    MakeDownloadSamplerJob.perform_async(@sampler.id)
    redirect_to sampler_path(@sampler)
  end

  def show
    @spotify_user = RSpotify::User.find(session[:user_id])
    @playlists = @spotify_user.playlists
    @playlists.each do |playlist|
      if playlist.id == session[:playlist_id]
        @playlist = playlist
      end
    end
    @sampler = Sampler.find_by(id: params[:id])
  end

end
