class GigsController < ApplicationController

  before_action :set_gig, only: [:show]

  def index
    @gigs = Gig.all
    # me = RSpotify::User.find(current_user.uid)
    @playlists = current_user.playlists #=> (Playlist array)

  # ----------------------------- A ---------------------------------
  # ---Trying to access the artists from all the playlists' tracks --
  # @playlists.last.tracks.last.artists #=> returns an array

    @unique_artists = current_user.playlist_artist_names(params[:playlist_id])

    # -------- THE CODE IN THE VIEWS/GIGS/INDEX.HTML.ERB
    # <h3>ALL MY ARTISTS</h3>
    # <ul>
    #   <% @unique_artists.each do |artist| %>
    #   <li><%= artist %></li>
    #   <% end %>
    # </ul>

# ------------------------------- B -------------------------------
# ---------- Trying to get the top-artists of the user ------------
    @top_artists = current_user.top_artists


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

# ------------------------------ F --------------------------------
# ---------------------- GIGS filtered by PL  ---------------------
    # if params[:playlist_id].present?
    #   @playlist = RSpotify::Playlist.find(current_user.uid, params[:playlist_id])

    # end

  end

  def show
  render layout: false if params[:inline] == 'true'
  end

  private

  def set_gig
    @gig = Gig.find(params[:id])
  end

end
