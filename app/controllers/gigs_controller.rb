class GigsController < ApplicationController

  before_action :set_gig, only: [:show]

  def index

    @gigs = Gig.all

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
    if params[:playlist_id].present?
      @playlist = RSpotify::Playlist.find(current_user.uid, params[:playlist_id])
      @playlist.tracks.each do |track|
        @all_artists << track.artists
        @all_artists.each do |artist|
          @artist_names << artist[0].name
        end
      end
    else
      @playlists.each do |playlist|
        @tracks = playlist.tracks
        @tracks.each do |track|
          @all_artists << track.artists
          @all_artists.each do |artist|
            @artist_names << artist[0].name
          end
        end
      end
    end
      @unique_artists = @artist_names.uniq

# ------------------------------- B -------------------------------
# ---------- Trying to get the top-artists of the user ------------
    @top_artists = me.top_artists.map do |artist|
      artist.name
    end

# ------------------------------- C -------------------------------
# ---- FILTERING THE GIGS vs all PL artists (@unique_artists) ----
    # @playlist_gigs = []
    # if params[:query].present?
    #   # cutting the params before "," and getting only the clear city
    #   city_only = params[:query].split(",").first
    #   @playlist_gigs = Gig.where(artist_name: @unique_artists, city: city_only)
    # else
    #   @playlist_gigs = Gig.where(artist_name: @unique_artists)
    # end

    @query = "#{params[:city]} #{params[:artist_name]}"
    if @query.present?
      @playlist_gigs = Gig.search_by_city_and_artist_name(@query)
    elsif params[:search].present?
      @playlist_gigs = Gig.where('date BETWEEN ? AND ?', params[:search][:starts_at].split(" to ")[0], params[:search][:starts_at].split(" to ")[1])
      # Comment.where('created_at BETWEEN ? AND ?', @selected_date.beginning_of_day, @selected_date.end_of_day)
    else
      @playlist_gigs = Gig.where(artist_name: @unique_artists)
    end

    # @playlist_gigs = Gig.where(artist_name: @unique_artists)

# ------------------------------ D --------------------------------
# ---- FILTERING the gigs vs top-artists (@top_artists) -----------
    # @top_gigs = []
    @top_gigs = Gig.where(artist_name: @top_artists)

# ------------------------------ E --------------------------------
# ---------------------- PHOTO of the user ------------------------
# RSpotify::User.find('kate.syrmakesi').images[0]["url"]
    @url = RSpotify::User.find(current_user.uid).images[0]["url"]


  end

  def show
  render layout: false if params[:inline] == 'true'
  end

  private

  def set_gig
    @gig = Gig.find(params[:id])
  end

end
