require 'rspotify/oauth'

Rails.application.config.to_prepare do
  OmniAuth::Strategies::Spotify.include SpotifyOmniauthExtension
end

Rails.application.config.middleware.use OmniAuth::Builder do

  provider :spotify, ENV["SPOTIFY_ID"], ENV["SPOTIFY_PWD"], scope: %w(
      playlist-read-private
      playlist-read-collaborative
      user-read-private
      user-read-email

      ugc-image-upload

      user-read-recently-played
      user-top-read
      user-read-playback-position

      user-read-playback-state
      user-modify-playback-state
      user-read-currently-playing

      app-remote-control
      streaming

      playlist-modify-public
      playlist-modify-private
      playlist-read-private
      playlist-read-collaborative

      user-follow-modify
      user-follow-read

      user-library-modify
      user-library-read

      user-read-email
      user-read-private

    ).join(' ')
end
