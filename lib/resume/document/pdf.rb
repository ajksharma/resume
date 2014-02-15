#lib/resume/document/pdf.rb

# PDF renderer for the resume DSL library.
# It uses Prawn, so I highly recommend checking out
# its manual.
class Resume::Document::Pdf < ::Prawn::Document
  prepend ::Resume::Document

  delegate :background, :name, :to => :resume, :prefix => true

  @@print_background = false

  # Disables background printing, so one
  # gets a better document for physical printing.
  def self.print_background= (value)
    @@print_background = value
  end

  # #########################################
  # Resume Interface
  # These methods are expected by the resume
  # library.

  # Formats the email:
  # * underline.
  # * blue font.
  # * clickable link to email address.
  def email (data)
    self.formatted_text [ self.href(data, "mailto:#{data}") ]
  end

  # Formats a block for an experience (job, education, etc)
  # name:: bold
  # url:: underline blue clickable link
  # Month YYYY - Month YYYY ( duration ) :: duration in grey font.
  # Summary Text
  # Notes:: list
  def experience (data, opts = {})
    self.group do
      self.h2 opts[:title] || 'Experience'
      data.inject([]) { |h,i| h << _print_experience(i) }
    end
  end

  # Renders the name
  # * 16 pt font.
  # * Bold
  def name (data)
    self.h1(data)
  end

  # Renders a category list in a table.
  def skills_list (data, opts = {})
    self.group do
      self.h2 opts[:title] || 'Skills'
      self.table(data.to_a.map { |i| [ "\u2022 #{i[0]}", i[1].join(', ') ] }, 
                :cell_style => {
                      :borders  => [],
                      :overflow => :shrink_to_fit, 
                      :min_font_size => 8,
                      :padding => [0,0,0,0],
                      :size => 12,
                      :height => 18 })
    end
  end
 
  # Renders a text block. 
  def summary (data)
    self.group do
      self.h2 'Summary'
      self.text data, :indent_paragraphs => 20
    end
  end

  # Renders a title.
  def title (data)
    self.text data.to_s.titleize
  end

  # #########################################
  
  # Prawn Overrides
 
  # Uses the name on the resume as the basis for the filename. 
  def render_file(*args)
    super("#{self.resume_name.titleize}'s Resume.pdf")
  end   
 
  # Mostly this is overridden to allow for a background image.
  # Essentially you draw the image, at a height and width of the
  # page. And to make things more complicated you build a set of 
  # coordinates to repeat x and repeat y.
  # After this reset the cursor, so you can draw the rest of the 
  # content over the image.
  def start_new_page(options = {})
    ret   = super
    start = self.cursor
    unless @@print_background == false || self.resume_background.nil?
      self.canvas do
        c = self.image self.resume_background, :at => [0,0]

        # Build a coordinate map
        m = (0..(self.bounds.width + c.width)).step(c.width).map do |x|
          (0..(self.bounds.height + c.height)).step(c.height).map do |y|
            self.image self.resume_background, :at => [x, y]
          end
        end
      end
    end
    self.move_cursor_to start
    return ret
  end

  # Helper Functions
  
  def h1 (t)
    self.font('Helvetica', :size => 16, :style => :bold) do
      self.formatted_text [{:text => t }]
    end
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

  private 

  def _print_experience (xp)
    attr = xp.attributes || {}

    group do
      self.move_down 8
      self.text attr[:title], :style => :bold

      if attr[:site]
        self.formatted_text [ 
          { :text => 'Website: ' }, 
          self.href(attr[:site],attr[:site]) 
        ]
      end
    
      if attr[:start_date] && attr[:end_date]
        _print_experience_dates(attr[:start_date],
                                attr[:end_date])
      end

      # Description
      self.formatted_text [{ 
        :text  => attr[:text], 
        :color => [80,40,40,50]
      }]

      _print_experience_notes(attr[:notes]) if attr[:notes]
    end
  end

  # Returns a text box for experience dates
  def _print_experience_dates(start_date, end_date)
    self.formatted_text [
      { :text =>  [ start_date, 
                    end_date 
                  ].map do |d| 
                    if(d.respond_to?(:strftime))
                      d.strftime("%B %Y") 
                    else
                      "#{d}".titleize
                    end
                  end.join(' - ') << ' ' 
      },
      { :text   => _time_difference( start_date, end_date),
        :color  => [0,0,0,50]
      }
    ]
  end

  # Prints notes
  # * Inserts a unicode bullet in front of each one.
  # * Then joins it to one string with a newline.
  def _print_experience_notes(notes)
    self.indent(20) do
      self.formatted_text [{
        :text  => notes.map { |n| "\u2022 #{n}" }.flatten.join("\n"),
        :color => [80,40,40,50]
      }]
    end
  end

end
