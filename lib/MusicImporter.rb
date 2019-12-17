class MusicImporter
  attr_accessor :path, :library

  def initialize(filepath)
    @path = filepath
    @library = []
  end

  def files
    Dir.entries(@path).select{ |f|
     f.include?(".mp3")
   }
  end

  def import
    files.each{ |file|
      @library << Song.create_from_filename(file)
    }
  end

end
