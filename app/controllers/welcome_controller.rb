class WelcomeController < ApplicationController

  def download
    song_name = params[:song_name]
    send_file("public/assets/songs/#{song_name}.mp3")
  end
end
