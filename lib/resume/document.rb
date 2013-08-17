#!/usr/bin/env ruby

module Resume

  class Document < ::Prawn::Document

    def start_new_page(options = {})
      ret   = super
      start = self.cursor
      self.canvas do
        c = self.image File.join(File.dirname(__FILE__),'/images/straws.png'), :at => [0,0]

        # Build a coordinate map
        m = (0..(self.bounds.width + c.width)).step(c.width).map do |x|
          (0..(self.bounds.height + c.height)).step(c.height).map do |y|
            self.image File.join(File.dirname(__FILE__),'/images/straws.png'), :at => [x, y]
          end
        end
      end
      self.move_cursor_to start
      return ret
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

    def print_education  (education)
      unless education.nil? || education.empty?
        self.h2 'Education'
        education.each do |e|
          _print_school( e.title, e.summary )
        end
      end
    end

    def print_experience (jobs)
      unless jobs.nil? || jobs.empty?
        self.h2 'Experience'
        jobs.sort { |a,b| b.start_on <=> a.start_on }.each do |j|
          _print_job( j.title, j.start_on, j.end_at, j.summary, j.notes)
        end
      end
      self
    end

    def print_projects (projects)
      unless projects.nil? || projects.empty? 
        self.h2 'Projects'
        projects.sort { |a,b| b.start_on <=> a.start_on }.each do |j|
          _print_job(j.title, j.start_on, j.end_at, j.summary, j.notes, j.url)
        end
      end
      self
    end

    def print_samples (samples)
      unless samples.nil? || samples.empty?
        self.h2 'Code Samples'
        samples.sort { |a,b| a.title <=> b.title }.each do |s|
          site = "https://github.com/bloodycelt/#{s.title}"
          self.text s.title.to_s.titleize, :style => :bold
          self.formatted_text [
            { :text => 'Website: ' },
            self.href(site, site)
          ]
          self.formatted_text [{
            :text => s.summary,
            :color => [80,40,40,50]
          }]
        end
      end
    end

    private    
    def _print_job (title, start_date, end_date, text, notes, site = nil)
      group do
        self.move_down 8
        self.text title, :style => :bold
        self.formatted_text [ { :text => 'Website: ' }, self.href(site,site) ] if site
          
        self.formatted_text [
          { :text => [ start_date, end_date ].map { |d| d.strftime("%B %Y") }.join(' - ') << ' ' },
          _time_difference(start_date,end_date)
        ]
        self.formatted_text [
          { :text => text,
            :color => [80,40,40,50]
          }
        ]
        unless notes.nil? || notes.empty?
          self.indent(20) do
            self.formatted_text [{
              :text  => notes.map { |n| "\u2022 #{n}" }.flatten.join("\n"),
              :color => [80,40,40,50]
            }]
          end
        end
      end
    end

    def _print_school (title, text)
        group do
          self.move_down 8
          self.text title, :style => :bold
        end 
        self.formatted_text [
          { :text => text,
            :color => [80,40,40,50]
          }
        ]
    end

    def _time_difference(start_date, end_date)
      t      = TimeDifference.between(start_date,end_date)
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
