module Resume
  module Experience 
    class Job < Base
      
      def attributes
        super.merge(
          :title => "#{title.to_s.titleize} at #{options[:at].to_s.titleize}"
        )
      end
      
      def initialize(attributes = {}, &block)
        super
        self.at ||= 'Please specify :at'
      end
      
    end
  end
end
