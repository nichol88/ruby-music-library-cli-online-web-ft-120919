class Genre
  extend Concerns::Findable
  include Concerns::Findable

  @@all = []

  attr_accessor :name, :songs

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def artists
    @songs.collect{ |song|
      song.artist
    }.uniq
  end
  

end
