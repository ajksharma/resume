module Resume
  module Experience 
    class Degree < Base 

      attr_accessor :majors

      def title
        [ _degree_lookup[super.to_sym],
          self.majors.join("/"),
          "#{self.start_on.year} - #{self.end_at.year}"
        ].compact.join(' ')
      end

      def major (value)
        ( self.majors ||= [] ) << value.to_s.titleize
      end
    
      private
      def _degree_lookup
        {
          :ba => 'Bachelor of Arts (B.A)'
        }
      end

      def _parse_date(year, _not_used)
        if year == :present
          Time.now
        else
          Time.new(year)
        end 
      end
    end
  end
end
