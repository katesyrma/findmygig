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
    @playlists = me.playlists #=> (Playlist array)
  end

  def show
  end

  private

  def set_gig
    @gig = Gig.find(params[:id])
  end

end
