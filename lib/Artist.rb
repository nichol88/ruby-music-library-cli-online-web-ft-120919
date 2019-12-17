class Artist

  extend Concerns::Findable
  include Concerns::Findable

  attr_accessor :name, :songs

  @@all = []

  def self.all
    @@all
  end

  def initialize(name)
    @name = name
    @songs = []
  end

  def add_song(song)
    if song.artist != self && !@songs.include?(song)
      song.artist = self
      @songs << song
      #binding.pry
    end
  end

  def genres
    @songs.collect{ |song|
      song.genre
    }.uniq
  end

end
