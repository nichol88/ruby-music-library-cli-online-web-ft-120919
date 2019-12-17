class Song
  extend Concerns::Findable
  include Concerns::Findable

  @@all = []

  attr_accessor :name, :genre
  attr_reader :artist

  def initialize(name, artist = {}, genre = {})
    @name = name
    artist.add_song(self)  if artist != {}
    self.genre= (genre)
    #binding.pry if genre
  end

  def self.all
    @@all
  end

  def artist=(artist)
    if !artist.songs.include?(self) && @artist != artist
      @artist = artist
      artist.add_song(self)
    end
  end

  def genre=(genre)
    #genre.add_song(self) if genre != {}
    if genre != {}
      if !genre.songs.include?(self)
        @genre = genre
        genre.songs << self
      end
    end
  end

  def self.find_or_create_by_name(name)
    if self.find_by_name(name) == nil
      Song.create(name)
    else
      return self.find_by_name(name)
    end
  end

  def self.new_from_filename(filename)
    #binding.pry
    data = filename.delete_suffix(".mp3").split(" - ")
    artist = Artist.find_or_create_by_name(data[0])
    genre = Genre.find_or_create_by_name(data[2])
    Song.new(data[1], artist, genre)

  end

  def self.create_from_filename(filename)
    s = Song.new_from_filename(filename)
    s.save
    s
  end


end
