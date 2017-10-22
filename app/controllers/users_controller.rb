class UsersController < ApplicationController

  def index
    #
  end

  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    p spotify_user.display_name
    if spotify_user.display_name
      display_name = spotify_user.display_name
    else
      display_name = spotify_user.email
    end
    # this should be a validation callback
    if spotify_user.images.empty?
      profile_pic_url = "https://img.buzzfeed.com/buzzfeed-static/static/2014-11/7/18/enhanced/webdr01/longform-original-18085-1415403731-23.jpg?crop=612:612;221,96&downsize=715:*&output-format=auto&output-quality=auto"
    else
      profile_pic_url = spotify_user.images[0][:url]
    end
    user = User.find_or_create_by(display_name: display_name, email: spotify_user.email, spotify_id: spotify_user.id, profile_pic_url: profile_pic_url)
    session[:user_id] = spotify_user.id
    redirect_to user_path(current_user)
  end

  def show
    @user = User.find(params[:id])
    @spotify_user = RSpotify::User.find(@user.spotify_id)
  end
end
