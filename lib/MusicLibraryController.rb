class MusicLibraryController

  attr_accessor :list

  def initialize(path = "./db/mp3s")
    MusicImporter.new(path).import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."

    loop do
      puts "What would you like to do?"
      input = gets.strip
      break if input == "exit"

      case input.downcase
      when 'list songs'
        list_songs
      when 'list artists'
        list_artists
      when 'list genres'
        list_genres
      when 'list artist'
        list_songs_by_artist
      when 'list genre'
        list_songs_by_genre
      when 'play song'
        play_song
      end

    end
  end

  def list_songs
    @list = Song.all.sort_by{ |s| s.name}
    @list.each_with_index{ |song, i|
      puts "#{i + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    }
    return @list
  end

  def list_artists
    @list = Artist.all.sort_by{ |a| a.name}
    @list.each_with_index{ |a, i|
      puts "#{i + 1}. #{a.name}"
    }
    return @list
  end

  def list_genres
    @list = Genre.all.sort_by{ |a| a.name}
    @list.each_with_index{ |a, i|
      puts "#{i + 1}. #{a.name}"
    }
    return @list
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist = gets.strip
    @list = Song.all.select{ |song|
      song.artist.name == artist
    }.sort_by{|e| e.name}

    @list.each_with_index{ |s, i|
      puts "#{i + 1}. #{s.name} - #{s.genre.name}"
    }
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre = gets.strip
    @list = Song.all.select{ |song|
      song.genre.name == genre
    }.sort_by{|e| e.name}

    @list.each_with_index{ |s, i|
      puts "#{i + 1}. #{s.artist.name} - #{s.name}"
    }
  end

  def play_song
    puts "Which song number would you like to play?"
    #list = Song.all.sort_by{|s| s.name }
    input = gets.strip.to_i
    song = @list[input - 1]
    if input > 0 && input <= list.length
      puts "Playing #{song.name} by #{song.artist.name}"
    end
  end
end
