
module Resume
  class Railtie < Rails::Railtie
    initializer 'resume.view_helpers' do
      ActionView::Base.send :include, ViewHelpers
    end
  end
end
