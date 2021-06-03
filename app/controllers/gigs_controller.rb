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

  # ----------------------------- A ---------------------------------
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

# ------------------------------- B -------------------------------
# ---------- Trying to get the top-artists of the user ------------
    @top_artists = me.top_artists.map do |artist|
      artist.name
    end

# ------------------------------- C -------------------------------
# ---- FILTERING THE GIGS vs all PL artists (@unique_artists) ----
    # @playlist_gigs = []
    @playlist_gigs = Gig.where(artist_name: @unique_artists)
    # @gigs.each do |gig|
    #   if @unique_artists.include?(gig.artist_name)
    #     @playlist_gigs << gig
    #   end
    # end

# ------------------------------ D --------------------------------
# ---- FILTERING the gigs vs top-artists (@top_artists) -----------
    # @top_gigs = []
    @top_gigs = Gig.where(artist_name: @top_artists)
    # @gigs.each do |gig|
    #   if @top_artists.include?(gig.artist_name)
    #     @top_gigs << gig
    #   end
    # end

# ------------------------------ E --------------------------------
# ---------------------- PHOTO of the user ------------------------
# RSpotify::User.find('kate.syrmakesi').images[0]["url"]
    @url = RSpotify::User.find(current_user.uid).images[0]["url"]

  end

  def show
  end

  private

  def set_gig
    @gig = Gig.find(params[:id])
  end

end
