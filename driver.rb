#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
Bundler.require

class Resume < Prawn::Document
  
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

end

Resume.generate('hello.pdf') do |pdf|

  def pdf.h2 (t) 
    group do
      self.stroke { self.horizontal_rule }
      self.move_down 12
      self.font('Helvetica', :style => :bold, :size => 14) do
        self.formatted_text [{ :text => t, :color => [40,20,20,50]}]
      end
    end
  end

  def pdf.job (title, start_date, end_date, text)
    group do
      self.move_down 8
      self.text title, :style => :bold
      t = TimeDifference.between(start_date,end_date)
      years  = t.in_years.floor
      months = t.in_months.floor % 12
        
      self.formatted_text [
        { :text => start_date.strftime("%B %Y") << ' - ' << 
                   end_date.strftime("%B %Y") << ' '
        },
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
      ]
      self.formatted_text [{ :text => text, :indent_paragraphs => 20, :color => [80,40,40,50]}]
    end
  end

  pdf.font('Helvetica', :size => 16, :style => :bold) do
    pdf.text("Jason Kenney")
  end
  pdf.text("Programmer at Liaison International")
  pdf.text("therealjasonkenney@gmail.com")
  pdf.h2 'Meta'
  pdf.table([
    ["\u2022 Ruby", "Rails 3..4.x, Prawn, RSpec, Capistrano, Rack, Chef"],
    ["\u2022 Perl", "CGI::Application"],
    ["\u2022 Javascript/CSS", "JQuery, AngularJS" ],
    ["\u2022 Databases", "SQL Server, Postgres, SOLR/Lucene"], 
    ["\u2022 Tools", "Git, Subversion, Vi, Omnigraffle, Visio, JIRA/Confluence"],
    ["\u2022 Other", "XSLT, Apache FOP, Control-M, C, GLSL, IPC, Lisp"]
  ], :cell_style => { :borders => [], 
                      :overflow => :shrink_to_fit, 
                      :min_font_size => 8,
                      :padding => [0,0,0,0],
                      :size => 12,
                      :height => 18 })
  pdf.h2 'Summary'
  pdf.text <<HERE, :indent_paragraphs => 20
Jason Kenney was born in the small land of Rhode Island, den of thieves. After eighteen years of imprisonment in the shamefully small state he received his letter from the Hartford School of Witchcraft and Wizardry.
There he was taught the arcane knowledge of names and symbols of power, of registers and apis, of mystical languages. Of Perl: the language of the gods, which if read can drive one mad.
After finishing his apprenticeship, Jason Kenney went on many boring adventures in the wonderful land of IT. (Rumors of his involvement with the Patchwork Girl are unsubstantiated).
HERE

  pdf.h2 'Experience'
  pdf.job 'Programmer at Liaison International',
          Time.new(2009,4),
          Time.now,
          <<HERE
Full stack developer responsible for the development and support of several web portals for admissions.

\u2022 Designed and implemented a change management process and workflow using Git, and Jira, documented with Omnigraffle.
\u2022 Refactored the financial reporting libraries in 22 applications into one single library.
\u2022 Built and maintained two web applications for college admissions (AACPMAS and Nursing).
\u2022 Designed, modeled, and architected a brand new service for tracking psychology hours.
\u2022 Hacked capistrano to work with our legacy perl applications.
\u2022 Rebuilt our ruby servers to leverage Chef and Bluepill.
\u2022 Mentored (and tolerated) junior programmers.
\u2022 Beat coworkers at Diplomacy
HERE
 
  pdf.job 'Release Engineer at Accenture Technology Solutions', 
          Time.new(2005,07), 
          Time.new(2009,02),
          <<HERE
  Watchdog and enforcer of change management processes (and Sarbanes-Oxley)

  \u2022 Designed and implemented a change management process and workflow using Harvest, and Clearquest, documented with Visio.
  \u2022 Built the migration script to move packages from Harvest to Oracle in Perl.
  \u2022 Designed the Job Process flow for the Nightly ETL using Control-M and Visio. 
HERE
  
  pdf.job 'Educational Technologist at University of Hartford FCLD (Work-Study)',
          Time.new(2004,9),
          Time.new(2005,5),
          <<HERE
Helped faculty acclimate to blackboard, and assited with adminstrative tasks.
HERE

  pdf.h2 'Projects'

  pdf.job 'My Psych Track', Time.new(2012,03), Time.now, <<HERE
   A web portal that helps psychology students track their "hours". Built with Ruby on Rails, Apache SOLR, and Postgres SQL.
HERE

  pdf.job 'NursingCAS', Time.new(2009,10), Time.now, <<HERE
A web portal that allows for application to multiple schools in the field of Nursing (AACN). Built with blood, sweat, tears and Perl.
HERE
 
  pdf.job 'CAS Financial Reporting Library', Time.new(2011,04), Time.new(2012,4), <<HERE
  Core CAS Library for Financial Reporting, used in 12+ services. A combination of Perl modules, and MSSQL Stored Procedures, as well as installation documentation.
HERE
 
  pdf.job 'AACPMAS', Time.new(2010,03), Time.new(2010,8), <<HERE
A web portal for Podiatry Admissions, built in Perl.
HERE
 
  pdf.job 'Synergy', Time.new(2005,10), Time.new(2009,02), <<HERE
A Major Financial Reporting Project involving Informatica, Control-M, Oracle, Java, Kalido, Shareplex, and Microsoft Powerpoint.
HERE

  pdf.group do
    pdf.h2 'Education'
    pdf.text 'University of Hartford', :style => :bold
    pdf.formatted_text [{ :text => <<HERE, :color => [80,40,40,50]}]
  Bachelor of Arts (B.A), Computer Science/Creative Writing, 2000 - 2005
  Activities and Societies: University of Hartford Sci-Fi/Fantasy Guild (V.P)
HERE
  end

  pdf.group do
    pdf.h2 'Hobbies/Interests'
    pdf.table([  
      ["\u2022 Literature", "Medieval, Postmodern, Mythology and Folklore"],
      ["\u2022 Film", "Kurosawa, Animation" ],
      ["\u2022 Other", "Code Spelunking, Digital Photography, Interactive Media, Hiking"]
    ], :cell_style => { :borders => [], 
                        :overflow => :shrink_to_fit, 
                        :min_font_size => 8,
                        :padding => [0,0,0,0],
                        :size => 12,
                        :height => 18 })
  end
end
