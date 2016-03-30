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
    self.doc.add_child( section(:class => 'experience-section') do |section_node|
      section_node.add_child( h2(opts[:title] || 'Experience' ) )

      data.map do |i|
        _print_experience(i)
      end.each do |i|
        section_node.add_child(i)
      end
    end )
  end

  # Renders the name
  # * 16 pt font.
  # * Bold
  def name (data)
    self.h1(data)
  end

  def section(opts = {})
    _new_node('section', self.doc).tap do |section_node|
      opts.each { |k,v| section_node[k.to_s] = v }
      yield section_node if block_given?
    end
  end

  # Renders a category list in a table.
  # I use bootstrap classes when needed.
  def skills_list (data, opts = {})
    self.doc.add_child( section(:class => 'skills-section') do |section_node|
      section_node.add_child( self.h2(opts[:title] || 'Skills') )
      table           = Nokogiri::XML::Node.new 'table', self.doc
      table['class']  = 'table skills-list'

      data.to_a.each do |i| 
        tr    = Nokogiri::XML::Node.new 'tr', self.doc
        col1  = Nokogiri::XML::Node.new 'td', self.doc
        col2  = Nokogiri::XML::Node.new 'td', self.doc

        col1.content = "\xe2\x80\xa2 #{i[0]}"
        col2.content = i[1].join(', ') 
        
        tr.add_child(col1)
        tr.add_child(col2)

        table.add_child(tr)
      end

      section_node.add_child(table)
    end )
  end
 
  # Renders a text block. 
  def summary (data)
    self.doc.add_child(section(:class => 'summary-section') do |section_node|
      section_node.add_child(self.h2('Summary'))
      section_node.add_child(p(data, :class => 'resume-summary'))
    end )
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
    _new_node('h2', self.doc).tap do |h|
      h.content   = t
      h['class']  = 'resume-header'
    end
  end

  def h3 (t)
    h           = Nokogiri::XML::Node.new 'h3', self.doc
    h.content   = t
    h['class']  = 'resume-header'
    self.doc.add_child(h)
  end
    
  def p (t, opts = {})
    p_node         = Nokogiri::XML::Node.new 'p', self.doc
    p_node.content = t
    opts.each { |k,v| p_node[k.to_s] = v }
    p_node
  end

  def dl (opts = {})
    dl_node        = Nokogiri::XML::Node.new 'dl', self.doc
    opts.each { |k,v| dl_node[k.to_s] = v }
    yield dl_node if block_given?
    dl_node
  end

  def dt (opts = {})
    dt_node        = Nokogiri::XML::Node.new 'dt', self.doc
    opts.each { |k,v| dt_node[k.to_s] = v }
    yield dt_node if block_given?
    dt_node
  end

  def dd (opts = {})
    dd_node        = Nokogiri::XML::Node.new 'dd', self.doc
    opts.each { |k,v| dd_node[k.to_s] = v }
    yield dd_node if block_given?
    dd_node
  end

  def ul (opts = {})
    ul_node        = Nokogiri::XML::Node.new 'ul', self.doc
    opts.each { |k,v| ul_node[k.to_s] = v }
    yield ul_node if block_given?
    ul_node
  end

  def li (opts = {})
    li_node        = Nokogiri::XML::Node.new 'li', self.doc
    opts.each { |k,v| li_node[k.to_s] = v }
    yield li_node if block_given?
    li_node
  end
    

  def href (text, link = nil)
    a         = Nokogiri::XML::Node.new 'a', self.doc
    a['href'] = link || text
    a.content = text
    a  
  end

  def span (text, opts = {})
    span_node          = Nokogiri::XML::Node.new 'span', self.doc
    span_node.content  = text

    opts.each { |k,v| span_node[k.to_s] = v }

    span_node
  end

  private

  def _new_node(*args)
    Nokogiri::XML::Node.new(*args)
  end

  def _print_experience (xp)
    attr              = xp.attributes || {}
    title             = attr[:employer] || attr[:title] || ''
    # You need to use parenthesis to force the nodes to execute the blocks
    # first, then get added to the doc.
    dl(:class => 'resume-experience') do |section|

      section.add_child( dt do |title_node|
        title_node.add_child( p(title) )
        if attr[:start_date] && attr[:end_date]
          title_node.add_child( p( _print_experience_dates(attr[:start_date], attr[:end_date])))
        end
      end )

      if attr[:position]
        section.add_child( dd(:class => 'resume-experience-position') do |pos|
          pos.content = attr[:position]
        end )
      end

      if attr[:site]
        section.add_child( dd do |site|
          site.content      = 'Website: '
          site.add_child( href(attr[:site]) )
        end )
      end

      section.add_child( dd do |description|
        description.content = attr[:text]
      end )

      if attr[:notes]
        section.add_child( dd do |notes|
          notes.add_child(_print_experience_notes(attr[:notes])) if attr[:notes]
        end )
      end
    end
  end

  # Returns a text box for experience dates
  def _print_experience_dates(start_date, end_date)
    [ start_date, end_date ].map do |d| 
      if(d.respond_to?(:strftime))
        d.strftime("%B %Y") 
      else
        "#{d}".titleize
      end
    end.join(' - ') << ' ' 
  end

  # Prints notes
  # * Inserts a unicode bullet in front of each one.
  # * Then joins it to one string with a newline.
  def _print_experience_notes(notes)
    ul(:class => 'experience-notes') do |ul_node|
      notes.each do |n|
        ul_node.add_child( li do |note|
          note.content  = n
        end )
      end
    end
  end

end
