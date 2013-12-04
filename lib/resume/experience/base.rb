module Resume
  module Experience 
    class Base
      attr_accessor :title, :at, :start_on, :end_at, :summary, :notes
      
      def attributes
        {
          :title      => self.title.to_s.titleize,
          :end_date   => self.end_at,
          :start_date => self.start_on,
          :text       => self.summary,
          :notes      => self.notes
        } 
      end
      
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
          :present
        elsif year
          Time.new(year,DateTime.parse("#{month}").month)
        end
      end
    end
  end
end
