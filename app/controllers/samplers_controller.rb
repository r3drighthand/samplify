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

  def create
    @user = User.find_by(spotify_id: session[:user_id])
    @spotify_user = RSpotify::User.find(session[:user_id])
    @playlists = @spotify_user.playlists
    @playlists.each do |playlist|
      if playlist.id == session[:playlist_id]
        @playlist = playlist
      end
    end

    music_file = File.open("tmp/#{@playlist.name}-mp3s.txt", 'w')
    image_file = File.open("tmp/#{@playlist.name}-images.txt", 'w')

    p "music text file = #{music_file}"

    @playlist.tracks.each do |track|
      if track.preview_url
        music_file.puts("file " + track.preview_url.to_s)
      end
      if track.album.images
        p "start downloading image"
        IO.copy_stream(open("#{track.album.images[0]["url"]}"), "tmp/#{track.id}.jpg")
        image_file.puts("file '#{track.id}.jpg'")
        image_file.puts("duration 30")
      end
    end

    p music_file.nil?

    music_file.close unless music_file.nil?
    image_file.close unless image_file.nil?

    system "ffmpeg -y -f concat -safe 0 -protocol_whitelist 'file,http,https,tcp,tls' -i tmp/#{@playlist.name}-mp3s.txt -c copy tmp/concatuaudio.mp3"

    p "mp3 concat complete"

    system "ffmpeg -y -f concat -safe 0 -protocol_whitelist 'file,http,https,tcp,tls' -i tmp/#{@playlist.name}-images.txt -i tmp/concatuaudio.mp3 -c:a aac -b:a 128k -c:v libx264 tmp/#{@playlist.name}-sampler.mp4"

    p "video complete"

    # File.delete("tmp/#{@playlist.name}-mp3s.txt")
    # File.delete("tmp/#{@playlist.name}-images.txt")

    @file_name = "#{@playlist.name}-sampler.mp4"

    # s3 = Aws::S3::Resource.new(region: ENV['AWS_REGION'])
    # obj = s3.bucket('dbc-team-samplify-test').object(@file_name)
    # puts "Uploading file #{@file_name}"
    # obj.upload_file("tmp/#{@file_name}")
    # puts "Done"

    # File.delete("tmp/#{@file_name}")
    puts "Has been deleted"

    @sampler = Sampler.find_by(title: @playlist.name)
    @sampler.samplified = true
    @sampler.s3_url = "https://s3.us-east-2.amazonaws.com/dbc-team-samplify-test/#{@file_name}"
    p @sampler.save
    p @sampler
    redirect_to sampler_path(@sampler)
  end

  def update
    @sampler = Sampler.find_by(id: params[:id])

    # This is the no good code that shouldn't be in final:
    music_file = File.open("tmp/#{@sampler.id}-mp3s.txt", 'w')
    image_file = File.open("tmp/#{@sampler.id}-images.txt", 'w')
    @sampler.tracks.each do |track|
      if track.preview_url
        music_file.puts("file " + track.preview_url.to_s)
        ################################
        # This might work:
        image_file.puts("file https:#{track.image.url(:original)}")
        image_file.puts("duration 30")
      end
    end
    music_file.close unless music_file.nil?
    image_file.close unless image_file.nil?

    system "ffmpeg -y -f concat -safe 0 -protocol_whitelist 'file,http,https,tcp,tls' -i tmp/#{@sampler.id}-mp3s.txt -c copy tmp/keepItSimple.mp3"

    ########################################
    # This is the low-qual vid codec:
    ########################################

    system "ffmpeg -f concat -safe 0 -protocol_whitelist 'file,http,https,tcp,tls' -i tmp/#{@sampler.id}-images.txt -i tmp/keepItSimple.mp3 -c:a aac -b:a 128k -c:v ffmpeg tmp/#{@sampler.id}-sampler.mp4"

    @file_name= "#{@sampler.id}-sampler.mp4"
    s3 = Aws::S3::Resource.new(region: ENV['AWS_REGION'])
    obj = s3.bucket('dbc-team-samplify-test').object(@file_name)
    puts "Uploading file #{@file_name}"
    obj.upload_file("tmp/#{@file_name}")
    p '************************************'
    puts "Done"
    p '************************************'
  end

  def show
    @spotify_user = RSpotify::User.find(session[:user_id])
    @playlists = @spotify_user.playlists
    @playlists.each do |playlist|
      if playlist.id == session[:playlist_id]
        @playlist = playlist
      end
    end
    @sampler = Sampler.find_by(title: @playlist.name)
  end

end
