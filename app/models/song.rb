class Song < ActiveRecord::Base
  require 'csv'

  belongs_to :artist

  def artist_name
    self.try(:artist).try(:name)
  end

  def artist_name=(name)
    artist = Artist.find_or_create_by(name: name)
    self.artist = artist
  end

  def self.upload(csv)
    CSV.foreach(csv.path, headers: true) do |song|
      artist = Artist.find_or_create_by(name: song[1])
      Song.create(title: song[0], artist: artist)
    end
  end
end
