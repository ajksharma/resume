#!/usr/bin/env ruby

module Resume
  module Document
    
    attr_accessor :resume
    
    # This sets a basic initialize hook that 
    # runs your initialization, then adds the resume attribute.
    def initialize (resume, *args)
      self.resume = Base.new resume, :render => self
   
      super(*args)

      # Call :after_initialize hook if one is defined.
      self.after_initialize if self.respond_to?(:after_initialize)

      self.resume.render

      self
    end
  
    protected  

    # Internal method to get a string with
    # the difference in years/months between
    # start and end dates.
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

      '( ' << 
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
      end << ' ).'
    end # _time_difference
  end   # Document
end     # Resume
