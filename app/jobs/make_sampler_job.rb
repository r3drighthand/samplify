class MakeSamplerJob
  include SuckerPunch::Job

  def perform(sampler_id)
    ActiveRecord::Base.connection_pool.with_connection do
      # me = RSpotify::User.find('12122573728')
      # playlist = me.playlists.first

      music_file = File.open("tmp/#{@sampler.title}-mp3s.txt", 'w')
      image_file = File.open("tmp/#{@sampler.title}-images.txt", 'w')

#########################################
#  In this iteration we ditch the use of
#  the Spotify ID for tracks in favor of
#  our own Track class' PID column. Should
#  still be unique, but leaving a note in
#  case this is referenced later on.
#########################################
      @sampler.tracks.each do |track|
        if track.preview_url
          music_file.puts("file " + track.preview_url.to_s)
        end
        if track.image
          IO.copy_stream(open("#{track.image}"), "tmp/#{track.id}.jpg")
          image_file.puts("file '#{track.id}.jpg'")
          image_file.puts("duration 30")
        end
      end

      music_file.close unless music_file.nil?
      image_file.close unless image_file.nil?

      system "ffmpeg -f concat -safe 0 -protocol_whitelist 'file,http,https,tcp,tls' -i tmp/#{@sampler.title}-mp3s.txt -c copy tmp/keepItSimple.mp3"

      system "ffmpeg -f concat -safe 0 -protocol_whitelist 'file,http,https,tcp,tls' -i tmp/#{@sampler.title}-images.txt -i tmp/keepItSimple.mp3 -c:a aac -b:a 128k -c:v libx264 tmp/#{@sampler.title}-sampler.mp4"

      File.delete("tmp/#{@sampler.title}-mp3s.txt")
      File.delete("tmp/#{@sampler.title}-images.txt")

      @file_name= "#{@sampler.title}-sampler.mp4"

      s3 = Aws::S3::Resource.new(region: ENV['AWS_REGION'])
      obj = s3.bucket('dbc-team-samplify-test').object(@file_name)
      puts "Uploading file #{@file_name}"
      obj.upload_file("tmp/#{@file_name}")
      puts "Done"

      File.delete("tmp/#{@file_name}")
      File.delete("app/assets/images/#{@file_name}")
      puts "Has been deleted"
    end
  end
end