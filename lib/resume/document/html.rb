# lib/resume/document/html.rb

# An HTML renderer for resume.
# This allows say a rails site to call this class and return
# the html of the resume.
class Resume::Document::Html
  prepend Resume::Document

  attr_accessor :doc

  delegate :to_html, :to => :doc

  def initialize
    self.doc = ::Nokogiri::HTML::DocumentFragment.parse ''
  end

  # Resume Interface


  # #########################################
  # Resume Interface
  # These methods are expected by the resume
  # library.

  # Formats the email:
  # * underline.
  # * blue font.
  # * clickable link to email address.
  def email(data)
    p = Nokogiri::XML::Node.new 'p', self.doc
    p.add_child(self.href(data, "mailto:#{data}"))
    self.doc.add_child p
  end

  # Formats a block for an experience (job, education, etc)
  # name:: bold
  # url:: underline blue clickable link
  # Month YYYY - Month YYYY ( duration ) :: duration in grey font.
  # Summary Text
  # Notes:: list
  def experience (data, opts = {})
    self.h2 opts[:title] || 'Experience'
    data.inject([]) { |h,i| h << _print_experience(i) }
  end

  # Renders the name
  # * 16 pt font.
  # * Bold
  def name (data)
    self.h1(data)
  end

  # Renders a category list in a table.
  # I use bootstrap classes when needed.
  def skills_list (data, opts = {})
    self.h2 opts[:title] || 'Skills'
    table           = Nokogiri::XML::Node.new 'table', self.doc
    table['class']  = 'table skills-list'

    data.to_a.each do |i| 
      tr    = Nokogiri::XML::Node.new 'tr', self.doc
      col1  = Nokogiri::XML::Node.new 'td', self.doc
      col2  = Nokogiri::XML::Node.new 'td', self.doc

      col1.content = "&#2022; #{i[0]}"
      col2.content = i[1].join(', ') 
      
      tr.add_child(col1)
      tr.add_child(col2)

      table.add_child(tr)
    end

    self.doc.add_child(table)
  end
 
  # Renders a text block. 
  def summary (data)
    self.h2 'Summary' 
    p           = p data
    p['class']  = 'summary'
    self.doc.add_child(p)
  end

  # Renders a title.
  def title (data)
    self.doc.add_child p(data.to_s.titleize)
  end

  # Helper Functions
  
  def h1 (t)
    h           = Nokogiri::XML::Node.new 'h1', self.doc
    h.content   = t
    h['class']  = 'resume-header'
    self.doc.add_child(h)
  end

  def h2 (t) 
    h           = Nokogiri::XML::Node.new 'h2', self.doc
    h.content   = t
    h['class']  = 'resume-header'
    self.doc.add_child(h)
  end
    
  def p (t)
    p         = Nokogiri::XML::Node.new 'p', self.doc
    p.content = t
    p
  end

  def href (text, link = nil)
    a         = Nokogiri::XML::Node.new 'a', self.doc
    a['href'] = link || text
    a.content = text
    a  
  end

  private 

  def _print_experience (xp)
    attr              = xp.attributes || {}
    section           = Nokogiri::XML::Node.new 'section', self.doc
    section['class']  = 'resume-experience'

    title             = Nokogiri::XML::Node.new 'strong', self.doc
    title.content     = attr[:title]
    title_p           = Nokogiri::XML::Node.new 'p', self.doc
    title_p.add_child(title)

    section.add_child(title_p)
    
    if attr[:site]
      site              = Nokogiri::XML::Node.new 'p', self.doc
      site.content      = 'Website: '
      site.add_child( href(attr[:site]) )

      section.add_child(site)
    end
     
    if attr[:start_date] && attr[:end_date]
      section.add_child _print_experience_dates(attr[:start_date],
                                                attr[:end_date])
    end

    description          = p(attr[:text])
    description['class'] = 'experience-text'

    section.add_child description
    
    section.add_child(_print_experience_notes(attr[:notes])) if attr[:notes]
  end

  # Returns a text box for experience dates
  def _print_experience_dates(start_date, end_date)
    p             = Nokogiri::XML::Node.new 'p',     self.doc
    span          = Nokogiri::XML::Node.new 'span',  self.doc
    span['class'] = 'time-difference'
    p.content     =   [ start_date, end_date ].map do |d| 
                        if(d.respond_to?(:strftime))
                          d.strftime("%B %Y") 
                        else
                          "#{d}".titleize
                        end
                      end.join(' - ') << ' ' 

    span.content  = _time_difference( start_date, end_date)

    p.add_child span
    p
  end

  # Prints notes
  # * Inserts a unicode bullet in front of each one.
  # * Then joins it to one string with a newline.
  def _print_experience_notes(notes)
    ul          = Nokogiri::XML::Node.new 'ul', self.doc
    ul['class'] = 'experience-notes'

    notes.each do |n|
      li          = Nokogiri::XML::Node.new 'li', self.doc
      li.content  = n
      ul.add_child li
    end

    ul
  end

end
