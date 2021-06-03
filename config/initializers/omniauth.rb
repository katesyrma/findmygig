require 'rspotify/oauth'

Rails.application.config.to_prepare do
  OmniAuth::Strategies::Spotify.include SpotifyOmniauthExtension
end

# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :spotify,
#     Rails.application.credentials.spotify[:client_id],
#     Rails.application.credentials.spotify[:client_secret],
#     scope: 'user-read-email playlist-modify-public user-library-read user-library-modify'
# end
