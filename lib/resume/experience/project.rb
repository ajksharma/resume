#!/usr/bin/env ruby

module Resume
  module Experience 
    class Project < Base 

      alias :tech :note
      attr_accessor :url

      def site (value)
        self.url = value
      end

    end
  end
end
