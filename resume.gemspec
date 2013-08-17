Gem::Specification.new do |s|
  s.name        = 'resume'
  s.version     = '0.1.0'
  s.summary     = "Gem to build my resume."
  s.description = "For fun I chose to have a ruby gem generate my resume."
  s.authors     = ["Jason Kenney"]
  s.email       = 'bloodycelt@gmail.com'
  s.files       = %w(
    lib/resume.rb
    lib/resume/base.rb
    lib/resume/document.rb
    lib/resume/experience.rb
    lib/resume/experience/base.rb
    lib/resume/experience/degree.rb
    lib/resume/experience/job.rb
    lib/resume/experience/project.rb
    lib/resume/experience/school.rb 
    lib/resume/images/straws.png
  )
  s.homepage    = 'https://github.com/bloodycelt/resume'

  s.add_dependency 'time_difference', '~> 0.2.0'
  s.add_dependency 'prawn'
  
end
