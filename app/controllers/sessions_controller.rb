class SessionsController < ApplicationController
  def destroy
    session.delete(:user_id)
    redirect_to root_path
    # redirect_to "https://www.spotify.com/us/logout" # need to figure out how to get back to users (maybe need ajax?)
  end
end
