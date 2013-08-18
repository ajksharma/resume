module Resume
  module Experience 
    class Sample < Base
      
      def attributes
        super.slice(:title, :site, :text)
      end
    end
  end
end