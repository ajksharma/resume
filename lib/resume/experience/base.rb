#!/usr/bin/env ruby

module Resume
  module Experience 
    class Base
      attr_accessor :title, :at, :start_on, :end_at, :summary, :notes

      def initialize(attributes = {}, &block) 
        super()
        attributes.each { |k,v| self.send :"#{k}=", v }
        self.instance_exec(&block) if block_given?
        self
      end

      def from(month, year = nil)
        self.start_on = _parse_date(month, year)
      end

      def note(value)
        ( self.notes ||= [] ) << value
      end

      def to(month, year = nil)
        self.end_at = _parse_date(month, year)
      end

      def summarize(value)
        self.summary = value
      end

      private
      
      def _parse_date(month, year)
        if month == :present
          Time.now
        elsif year
          Time.new(year,DateTime.parse("#{month}").month)
        end
      end
    end
  end
end
