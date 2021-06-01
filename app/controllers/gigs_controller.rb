class GigsController < ApplicationController

  before_action :set_gig, only: [:show]

  def index
    @gigs = Gig.all
  end

  def show
  end

  private

  def set_gig
    @gig = Gig.find(params[:id])
  end
end
