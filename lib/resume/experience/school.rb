#!/usr/bin/env ruby

module Resume
  module Experience 

    class School < Base

      def degree (title, &block)
        ( @degrees ||= [] ) << Degree.new(:title => title, &block)
      end

      def end_at
        @degrees.map { |d| d.end_at   }.min
      end

      def start_on
        @degrees.map { |d| d.start_on }.min
      end

      def summary
        ( 
          ( @degrees ||= [] ).sort { |a,b| b.start_on <=> a.start_on }.map { |d| d.title } << super
        ).join("\n") 
      end

    end
  end
end
