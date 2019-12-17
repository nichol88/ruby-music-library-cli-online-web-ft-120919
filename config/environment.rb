require 'bundler'

Bundler.require


module Concerns

    module Findable

      def destroy_all
        self.all.clear
      end

      def create(name)
        s = self.new(name)
        s.save
        s
      end

      def save
        self.class.all << self
      end

      def find_by_name(name)
        self.all.find{ |instance| instance.name == name}
      end

      def find_or_create_by_name(name)

        if self.find_by_name(name) == nil
          self.create(name)
        else
          self.find_by_name(name)
        end

      end

    end # Findable

  end # Concerns

require_all 'lib'
