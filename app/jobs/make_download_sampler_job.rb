class MakeDownloadSamplerJob
  include SuckerPunch::Job
  # Does this inherit from App_Job.rb?

  def perform(sampler_id)
    p '************************************************'
    p 'done!'
    p '**************************************************'
    @sampler = Sampler.find_by(id: sampler_id)
    ActiveRecord::Base.connection_pool.with_connection do

      ############################################
      # DEPRECATED COMMANDS:
      # me = RSpotify::User.find('12122573728')
      # playlist = me.playlists.first
      ###########################################

      music_file = File.open("tmp/#{@sampler.id}-mp3s.txt", 'w')
      image_file = File.open("tmp/#{@sampler.id}-images.txt", 'w')

      @sampler.tracks.each do |track|
        if track.preview_url
          music_file.puts("file " + track.preview_url.to_s)
          image_file.puts("file https:#{track.image.url(:original)}")
          image_file.puts("duration 30")
        end
      end

      music_file.close unless music_file.nil?
      image_file.close unless image_file.nil?

      system "ffmpeg -y -f concat -safe 0 -protocol_whitelist 'file,http,https,tcp,tls' -i tmp/#{@sampler.id}-mp3s.txt -c copy tmp/keepItSimple.mp3"
      p '**********************************************'
      p 'This might not print anywhere'
      p '**********************************************'
      system "ffmpeg -f concat -safe 0 -protocol_whitelist 'file,http,https,tcp,tls' -i tmp/#{@sampler.id}-images.txt -i tmp/keepItSimple.mp3 -c:a aac -b:a 128k -c:v mpeg4 tmp/#{@sampler.id}-sampler.mp4"

      @file_name= "#{@sampler.id}-sampler.mp4"

      s3 = Aws::S3::Resource.new(region: ENV['AWS_REGION'])
      obj = s3.bucket('dbc-team-samplify-test').object(@file_name)
      # puts "Uploading file #{@file_name}"
      obj.upload_file("tmp/#{@file_name}")
      @sampler.samplified = true
      @sampler.s3_url = "https://s3.us-east-2.amazonaws.com/dbc-team-samplify-test/#{@file_name}"
      @sampler.save
      # puts "Done"
      ########################
      # Test:

#       File.delete("tmp/#{@file_name}")
#       File.delete("app/assets/images/#{@file_name}")
#       puts "Has been deleted"
    end
  end
end
