module Resume
  module Experience 
    class Sample < Base
     
      attr_accessor :under
 
      def attributes
        super.slice(:title, :text).merge(
          :site => [ root_url,
                     under.to_s.underscore,
                     title.to_s.underscore
                   ].compact.join('/')
        )
      end

      private
      
      def root_url
        'http://www.github.com'
      end
    end
  end
end
