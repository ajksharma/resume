Gem::Specification.new do |s|
  s.name        = 'resume'
  s.version     = '0.2.0'
  s.summary     = "Gem to build my resume."
  s.description = "For fun I chose to have a ruby gem generate my resume."
  s.authors     = ["Jason Kenney"]
  s.email       = 'bloodycelt@gmail.com'

  s.files       = %w(
    lib/resume.rb
    lib/resume/base.rb
    lib/resume/cli.rb
    lib/resume/document.rb
    lib/resume/document/pdf.rb
    lib/resume/experience.rb
    lib/resume/experience/base.rb
    lib/resume/experience/degree.rb
    lib/resume/experience/job.rb
    lib/resume/experience/project.rb
    lib/resume/experience/school.rb 
  )

  s.executables = %w(
    resume
  )

  s.homepage    = 'https://github.com/bloodycelt/resume'

  # Since I use prepend, this means ruby 2.0 or greater.
  s.required_ruby_version = '>= 2.0'

  s.add_dependency 'activesupport',   '>= 3.2'
  s.add_dependency 'time_difference', '~> 0.2.0'
  s.add_dependency 'clbustos-rtf'
  s.add_dependency 'prawn'
  s.add_dependency 'thor'
  
end
