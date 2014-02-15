
# Unlike prawn, the RTF library is... not as good as prawn.
# So the premise is... wrap code inside paragraphs, which can also contain sub-blocks
# for styled text... M$ came up with this... so yeah the format is bonkers.
# Anyhow, this implementation is just a barebones version with some typesetting of
# headers.
# Also, they are not arrays, it just uses operator overloading because... the author
# likes C++?
# Confused? Don't worry, so am I :)
# 1. The RTF library, is the only one out there and hasn't been touched in 2 years.
# 2. No time right now to roll my own, or fork that one...
# 3. Blame Spooner.
class Resume::Document::Rtf < ::RTF::Document
  prepend ::Resume::Document

  # Accessor to this objects information object.
  # as the RTF library will not provide it. 
  # Mostly used to control things in rspec.
  def information
    @information
  end
 
  # Resume Interface

  # Renders email
  # * blue
  # * underline  
  def email (data)
    self.paragraph(default_style) do |p|
      href(p) do |t|
        t << data
      end
    end
  end

  # Renders experience
  def experience (data, opts = {})
    self.h2 opts[:title] || 'Experience'
    data.inject([]) { |h,i| h << _print_experience(i) }
  end

  # Renders name
  # * 16 point font.
  # * bold.
  def name (data)
    self.h1(data)
  end

  # Renders a pseudo table.
  # Would have used a table, but RTF is too weird with that, 
  # so I'll just use good old
  # sprintf.
  def skills_list (data, opts = {})
  
    self.h2 opts[:title] || 'Skills'
    data.to_a.map { |i| sprintf("%-15s %s","\u2022 #{i[0]}", i[1].join(', ')) }.each do |r|
      self.paragraph(default_style) do |p|
        p << r
      end
    end
    
  end
 
  # Just a set of paragraphs. 
  def summary (data)
    style = ::RTF::ParagraphStyle.new(default_style)
    style.first_line_indent = 20 * 20 # This needs to be converted to RTF space.
    self.h2 'Summary'
    self.paragraph(style) do |p|
      p << data
    end
  end

  # Just the title.
  def title (data)
    self.paragraph(default_style) do |p|
      p << data.to_s.titleize
    end
  end
  
  # Helper FUnctions
 
  # In case I ever want global paragraph styles. 
  def default_style
    ::RTF::ParagraphStyle.new
  end
  
  def h1 (data)
    style           = ::RTF::CharacterStyle.new
    style.font_size = 16 * 2
    style.bold      = true
    
    self.paragraph(default_style) do |p|
      p.apply(style) do |t|
        t << data
      end
    end
    
  end

  def h2 (data)
    p_style               = ::RTF::ParagraphStyle.new(default_style)
    p_style.space_before  = 12 * 20
    style             = ::RTF::CharacterStyle.new
    style.font_size   = 14 * 2
    style.bold        = true
    style.foreground  = ::RTF::Colour.new 77, 102, 102
    
    self.paragraph(p_style) do |p|
      p.apply(style) do |t|
        t << data
      end
    end
  end

  def h3 (data) 
    p_style               = ::RTF::ParagraphStyle.new(default_style)
    p_style.space_before  = 8 * 20
    style                 = ::RTF::CharacterStyle.new
    style.bold            = true
    
    self.paragraph(p_style) do |p|
      p.apply(style) do |t|
        t << data
      end
    end
  end
  
  # This should get added to whatever p is...
  def href (p, &block)
    style             = ::RTF::CharacterStyle.new
    style.foreground  = ::RTF::Colour.new 4,69,173
    style.underline   = true
    
    p.apply(style) do |t|
      yield t
    end
    
  end
  
  private
 
  # A large mess... it prints experience blocks. 
  def _print_experience (xp)
    attributes                        = xp.attributes || {}
    text_style                        = ::RTF::CharacterStyle.new
    text_style.foreground             = ::RTF::Colour.new 25,77,77
    notes_style                       = ::RTF::ParagraphStyle.new
    notes_style.left_indent           = 20 * 20
    time_difference_style             = ::RTF::CharacterStyle.new
    time_difference_style.foreground  = ::RTF::Colour.new 128,128,128
    
    # move down 8
    self.h3 attributes[:title]
    if attributes[:site]
      self.paragraph(default_style) do |p|
        p << 'Website: '
        href(p) do |t|
          t << attributes[:site]
        end
      end
    end
    if attributes[:start_date] && attributes[:end_date]
      self.paragraph(default_style) do |p|
        p << ( [ attributes[:start_date], 
               attributes[:end_date] 
             ].map do |d| 
               if(d.respond_to?(:strftime))
                 d.strftime("%B %Y") 
               else
                 "#{d}".titleize
               end
             end.join(' - ') << ' ' )
             
        p.apply(time_difference_style) do |t|
          t << _time_difference(attributes[:start_date],attributes[:end_date])
        end
        
      end
    end
    
    self.paragraph(default_style) do |p|
      p.apply(text_style) do |t|
        t << attributes[:text]
      end
    end
    
    if attributes[:notes]
      attributes[:notes].map { |n| "\u2022 #{n}" }.flatten.each do |note|
        self.paragraph(notes_style) do |p|
          p.apply(text_style) do |t|
            t << note
          end
        end
      end
    end
  end

end
