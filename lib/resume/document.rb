#!/usr/bin/env ruby

module Resume

  class Document < ::Prawn::Document
    
    attr_accessor :resume
    
    delegate :name, :title, :email, :hobbies, :skills, :summary, :to => :resume, :prefix => true
    
    @@print_background = true
    
    def self.print_background= (value)
      @@print_background = value
    end
    
    # Set it up so resume actually stashes order of executions 
    # and this takes that ordered set and executes pdf commands on them.
    def initialize (resume, options={}, &block)
      super(options, &block)
      
      self.resume = Resume::Base.new resume, self
      
      # self.contact_info resume.name, :email => resume.email, :title => resume.title

      # self.skills_list 'Meta',  resume.skills
      
      # self.group do
      #  self.h2    'Summary'
      #  self.text  resume.summary, :indent_paragraphs => 20
      # end
      
      self.experience :jobs
      self.experience :projects, :title => 'Projects'
      self.experience :samples,  :title => 'Code Samples'
      self.experience :schools,  :title => 'Education'
      
      self.group do
        self.skills_list 'Hobbies/Interests', resume_hobbies
      end
      
    end
   
    def email (data)
      self.formatted_text [ self.href(data, "mailto:#{data}") ]
    end
    
    def experience (xp, opts = {})
      self.group do
        self.h2 opts[:title] || 'Experience'
        resume.send(xp.to_sym).inject([]) { |h,i| h << _print_experience(i) }
      end
    end
    
    def name (data)
      self.h1(data)
    end
    
    def skills (data)
      self.skills_list 'Meta', data
    end
    
    def summary (data)
      self.group do
        self.h2 'Summary'
        self.text data, :indent_paragraphs => 20
      end
    end
    
    def title (data)
      self.text data.to_s.titleize
    end
      
    def start_new_page(options = {})
      ret   = super
      start = self.cursor
      if @@print_background == true
        self.canvas do
          c = self.image File.join(File.dirname(__FILE__),'/images/straws.png'), :at => [0,0]

          # Build a coordinate map
          m = (0..(self.bounds.width + c.width)).step(c.width).map do |x|
            (0..(self.bounds.height + c.height)).step(c.height).map do |y|
              self.image File.join(File.dirname(__FILE__),'/images/straws.png'), :at => [x, y]
            end
          end
        end
      end
      self.move_cursor_to start
      return ret
    end

    def h1 (t)
      self.font('Helvetica', :size => 16, :style => :bold) { self.text t }
    end
    
    def h2 (t) 
      group do
        self.stroke { self.horizontal_rule }
        self.move_down 12
        self.font('Helvetica', :style => :bold, :size => 14) do
          self.formatted_text [{ :text => t, :color => [40,20,20,50]}]
        end
      end
    end

    def href (text, link)
      { :text => text,
        :link => link,
        :color => [97, 60, 0, 32], 
        :style => :underline
      }
    end

    def skills_list (heading, skills)
      self.group do
        self.h2 heading
        self.table(skills.to_a.map { |i| [ "\u2022 #{i[0]}", i[1].join(', ') ] }, 
                  :cell_style => {
                        :borders  => [],
                        :overflow => :shrink_to_fit, 
                        :min_font_size => 8,
                        :padding => [0,0,0,0],
                        :size => 12,
                        :height => 18 })
      end
    end
    
    private 
    
    def _print_experience (xp)
      attributes = xp.attributes || {}
      group do
        self.move_down 8
        self.text attributes[:title], :style => :bold
        if attributes[:site]
          self.formatted_text [ 
            { :text => 'Website: ' }, 
            self.href(attributes[:site],attributes[:site]) 
          ]
        end
        
        if attributes[:start_date] && attributes[:end_date]
          self.formatted_text [
            { :text =>  [ attributes[:start_date], 
                          attributes[:end_date] 
                        ].map do |d| 
                          if(d.respond_to?(:strftime))
                            d.strftime("%B %Y") 
                          else
                            "#{d}".titleize
                          end
                        end.join(' - ') << ' ' 
            },
            _time_difference(attributes[:start_date],attributes[:end_date])
          ]
        end
        self.formatted_text [{ :text => attributes[:text], :color => [80,40,40,50]}]
        if attributes[:notes]
          self.indent(20) do
            self.formatted_text [{
              :text  => attributes[:notes].map { |n| "\u2022 #{n}" }.flatten.join("\n"),
              :color => [80,40,40,50]
            }]
          end
        end
      end
    end
    
    def _time_difference(start_date, end_date)
      t      = TimeDifference.between(
        *([start_date,end_date].map do |d|
            if(d == :present)
              Time.now
            else
              d
            end
          end))
      years  = t.in_years.floor
      months = t.in_months.floor % 12

      { :text => '( ' << 
                 if years > 1
                   "#{years} years"
                 elsif years == 1
                   '1 year'
                 else
                   ''
                 end << 
                 if months > 1
                   " #{months} months"
                 elsif months == 1
                   ' 1 month'
                 else
                  ''
                 end << ' ).',
        :color => [0,0,0,50]
      }
    end

  end
end    
