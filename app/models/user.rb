class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:spotify] # add this line
  def spotify_user
    Rails.cache.fetch("#{cache_key_with_version}/spotify_user",
      expires_in: 1.hour) do
      RSpotify::User.new(
      {
        'credentials' => {
           "token" => self.token
           # "refresh_token" => self.credentials["refresh_token"],
           # "access_refresh_callback" => callback_proc
        },
        'id' => self.uid
      })
    end
  end

  def playlists
    Rails.cache.fetch("#{cache_key_with_version}/playlists",
      expires_in: 1.hour) do
      spotify_user.playlists(limit: 50, offset: 0)
  end
end

  def playlist_artist_names(playlist_id = 0)
    Rails.cache.fetch("#{cache_key_with_version}/playlist_artist_names/#{playlist_id}",
      expires_in: 1.hour) do
      all_artists = []
      artist_names = []
    if playlist_id.present?
      playlist = RSpotify::Playlist.find(self.uid, playlist_id)
      playlist.tracks.each do |track|
        all_artists << track.artists
        all_artists.each do |artist|
          artist_names << artist[0].name
        end
      end
    else
      playlists.each do |playlist|
        tracks = playlist.tracks
        tracks.each do |track|
          all_artists << track.artists
          all_artists.each do |artist|
            artist_names << artist[0].name
          end
        end
      end
    end

    artist_names.uniq
  end
end

  def top_artists
    Rails.cache.fetch("#{cache_key_with_version}/top_artists",
      expires_in: 1.hour) do
      spotify_user.top_artists.map do |artist|
        artist.name
      end
    end
  end

  def self.find_for_oauth(auth)
    # Create the user params
    user_params = auth.slice("provider", "uid")
    user_params.merge! auth.info.slice("email", "first_name", "last_name")
    user_params[:picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h
    # Finish creating the user params

    # Find the user if there was a log in
    user = User.find_by(provider: auth.provider, uid: auth.uid)

    # If the User did a regular sign up in the past, find it
    user ||= User.find_by(email: auth.info.email)

    # If we had a user, update it
    if user
      user.update(user_params)
    # Else, create a new user with the params that come from the app callback
    else
      user = User.new(user_params)
      # create a fake password for validation
      user.password = Devise.friendly_token[0,20]
      user.save
    end

    return user
  end
end
