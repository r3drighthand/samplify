class MakeDownloadSamplerJob
  include SuckerPunch::Job
  # Does this inherit from App_Job.rb?

  def perform(sampler_id)
    @sampler = Sampler.find_by(id: sampler_id)
    ActiveRecord::Base.connection_pool.with_connection do

      music_file = File.open("tmp/#{@sampler.id}-mp3s.txt", 'w')
      image_file = File.open("tmp/#{@sampler.id}-images.txt", 'w')
      @sampler.tracks.order("created_at ASC").each do |track|
        if track.preview_url
          music_file.puts("file " + track.preview_url.to_s)
          image_file.puts("file https:#{track.image.url(:original)}")
          image_file.puts("duration 30")
        end
      end
      music_file.close unless music_file.nil?
      image_file.close unless image_file.nil?

      system "ffmpeg -y -f concat -safe 0 -protocol_whitelist 'file,http,https,tcp,tls' -i tmp/#{@sampler.id}-mp3s.txt -c copy tmp/keepItSimple.mp3"
      ########################################
      # This is the high-qual vid codec
      ########################################
      system "ffmpeg -y -f concat -safe 0 -protocol_whitelist 'file,http,https,tcp,tls' -i tmp/#{@sampler.id}-images.txt -c:v libx264 -preset superfast simpleVideo.mp4"

      ########################################
      # This is the low-qual vid codec
      ########################################
      # system "ffmpeg -y -f concat -safe 0 -protocol_whitelist 'file,http,https,tcp,tls' -i tmp/#{@sampler.id}-images.txt -c:v mpeg4 simpleVideo.mp4"

      system "ffmpeg -y -i tmp/keepItSimple.mp3 -i simpleVideo.mp4 -c:v libx264 -c:a aac -b:a 128k -preset ultrafast tmp/#{@sampler.id}-sampler.mp4"

      @file_name= "#{@sampler.id}-sampler.mp4"

      s3 = Aws::S3::Resource.new(region: ENV['AWS_REGION'])
      obj = s3.bucket('dbc-team-samplify-test').object(@file_name)

      puts "Uploading file #{@file_name}"
      obj.upload_file("tmp/#{@file_name}")
      @sampler.samplified = true
      @sampler.s3_url = "https://s3.us-east-2.amazonaws.com/dbc-team-samplify-test/#{@file_name}"
      @sampler.save
    end
  end
end
