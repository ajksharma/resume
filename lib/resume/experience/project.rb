#!/usr/bin/env ruby

module Resume
  module Experience 
    class Project < Base 

      alias :tech :note
      attr_accessor :url

      def attributes
        super.merge(
          :title  => self.title.to_s.camelize,
          :site   => self.url
        )
      end
      
      def site (value)
        self.url = value
      end

    end
  end
end
