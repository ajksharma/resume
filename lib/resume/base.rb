#!/usr/bin/env ruby

module Resume

  class Base

    attr_accessor :summary

    def initialize(filename)

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
        pdf.group { pdf.print_experience self.jobs     }
        pdf.group { pdf.print_projects   self.projects }
        pdf.group { pdf.print_samples    self.samples  }
        pdf.group { pdf.print_education  self.schools  }
        pdf.group do
          pdf.skills_list 'Hobbies/Interests', self.hobbies
        end
      end 
    end
  
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

    def job (title, options = { :at => 'Please put at least at'}, &block)
      ( @jobs ||= [] ) << Experience::Job.new(:title => "#{title.to_s.titleize} at #{options[:at].to_s.titleize}", &block )
    end

    def jobs
      ( @jobs ||= [] ).sort { |a,b| b.start_on <=> a.start_on }
    end

    def name (value = nil)
      @name = value || @name || 'Please specify name'
    end

    def project (title, &block)
      ( @projects ||= [] ) << Experience::Project.new(:title => "#{title.to_s.camelize}", &block)
    end

    def projects
      @projects ||= []
    end

    def sample (title, summary)
      ( @samples ||= [] ) << Experience::Base.new(:title => title, :summary => summary)
    end

    def samples
      @samples ||= []
    end

    def school(title, &block)
      ( @schools ||= [] ) << Experience::School.new(:title => "#{title.to_s.camelize}", &block)
    end

    def schools
      ( @schools ||= [] ).sort { |a,b| b.start_on <=> a.start_on }
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
