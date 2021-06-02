class GigsController < ApplicationController

  before_action :set_gig, only: [:show]

  def index
    @gigs = Gig.all
    # me = RSpotify::User.find(current_user.uid)
    me = RSpotify::User.new(
      {
        'credentials' => {
           "token" => current_user.token
           # "refresh_token" => self.credentials["refresh_token"],
           # "access_refresh_callback" => callback_proc
        },
        'id' => current_user.uid
      })
    @playlists = me.playlists(limit: 50, offset: 0) #=> (Playlist array)

  # -----------------------------------------------------------------
  # ---Trying to access the artists from all the playlists' tracks --
  # @playlists.last.tracks.last.artists #=> returns an array
    @all_artists = []
    @artist_names = []
    @playlists.each do |playlist|
      @tracks = playlist.tracks
      @tracks.each do |track|
        @all_artists << track.artists
        @all_artists.each do |artist|
          @artist_names << artist[0].name
        end
      end
    end
    @unique_artists = @artist_names.uniq

    # -------- THE CODE IN THE VIEWS/GIGS/INDEX.HTML.ERB
    # <h3>ALL MY ARTISTS</h3>
    # <ul>
    #   <% @unique_artists.each do |artist| %>
    #   <li><%= artist %></li>
    #   <% end %>
    # </ul>

  # -----------------------------------------------------------------
  # ---------- Trying to get the top-artists of the user ------------
    @top_artists = me.top_artists
  # -----------------------------------------------------------------
  # -----------------------------------------------------------------
  end

  def show
  end

  private

  def set_gig
    @gig = Gig.find(params[:id])
  end

end
