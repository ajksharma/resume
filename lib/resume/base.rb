#!/usr/bin/env ruby

require 'resume/experience'

module Resume

  class Base
    extend Command
    extend Experience
    
    attr_accessor :summary
    
    has_experience :job, :project, :sample, :school
    
    def initialize(filename)

      # This part loads a script file which calls the commands to build resume objects.
      proc = ::Proc.new {}
      eval(::File.open(filename, 'r').read, proc.binding, filename)

      Document.generate("#{self.name.titleize}'s Resume.pdf") do |pdf|
        pdf.font('Helvetica', :size => 16, :style => :bold) do
          pdf.text self.name
        end
        pdf.text             self.title
        pdf.formatted_text [ pdf.href(self.email, "mailto:#{self.email}") ]
        pdf.group do
          pdf.skills_list 'Meta', self.skills
        end
        pdf.group do
          pdf.h2    'Summary'
          pdf.text  self.summary, :indent_paragraphs => 20
        end
        pdf.print_experience self.jobs
        pdf.print_experience self.projects, :title => 'Projects'
        pdf.print_experience self.samples,  :title => 'Code Samples'
        pdf.group { pdf.print_samples    self.samples  }
        pds.print_experience self.schools,  :title => 'Education'
        pdf.group do
          pdf.skills_list 'Hobbies/Interests', self.hobbies
        end
      end 
    end
  
    # commands for the dsl
    def email (value = nil)
      @email = value || @email || ''
    end

    def hobby(value, opts = { :under => :other } )
      ( ( @hobbies ||= {} )[opts[:under].to_s.titleize] ||= [] ) << value.to_s.camelize
    end

    def hobbies
      @hobbies ||= {}
      Hash[@hobbies.except('Other').sort].merge @hobbies.slice('Other')
    end

    def name (value = nil)
      @name = value || @name || 'Please specify name'
    end

    def samples
      ( @samples ||= [] ).sort { |a,b| a.title <=> b.title }
    end

    def skill(value, opts = { :under => :other } )
      ( ( @skills ||= {} )[opts[:under].to_s.titleize] ||= [] ) << value.to_s.camelize
    end

    def skills
      @skills ||= {}
      Hash[@skills.except('Other').sort].merge(@skills.slice('Other'))
    end

    def summarize (text)
      self.summary = text
    end

    def title
      self.jobs.first.try(:title)
    end
  end
end
