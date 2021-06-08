class Gig < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_city_and_artist_name,
    against: [:city, :artist_name],
    using: { tsearch: { prefix: true } }
end
