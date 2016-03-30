module Resume
  module Experience 
    class Job < Base
      
      def attributes
        super.merge(
          :employer => self.at.to_s.titleize,
          :position => title.to_s.titleize,
          :title    => "#{title.to_s.titleize} at #{self.at.to_s.titleize}"
        )
      end
      
      def initialize(attributes = {}, &block)
        super
        self.at ||= 'Please specify :at'
      end
      
    end
  end
end
