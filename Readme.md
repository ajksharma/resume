# Resume
The resume builder for my resume.

## Installation

```bash
git clone https://github.com/bloodycelt/resume.git resume
cd resume
bundle install
thor resume:build resume.rl
```

## Umm... Why !!??
* Because I was bored.
* Also, I needed some decent code samples for my resume, so why not?
* Yes, I could really use a life, do you have any to spare? 

## DSL

```ruby
  name  '<Your Name>'
  email '<Your email>'
```  
Skill that goes to the Ruby group
Sybmols here are CamelCased for skills and titlized for :under
```ruby
  skill :camel_casing, :under => :ruby
```  
If you need spacing use a string
```ruby
  skill 'I Like My Spaces', :under => :strange
```  
Other skill
```ruby
  skill :cat_throwing
```  
Hobbies work the same way
```ruby
  hobby :markdown, :under => :no_life
```  
Jobs and Projects are pretty much the same with some differences
  
Jobs require :at for employer
```ruby
  job :assasin, :at => :sony # Megatokyo reference
    # Dates are month, year -> whatever DateTime.parse can handle for month
    from :apr, 2005
    to   :september, 2009
    summarize <<HERE
    I can do HERE documents which slowly kill people by making them want to die!!!!
    HAHAHAHAHAHA
HERE
    note 'A small bulleted item can go here'
  end
```

Projects do not use :at, but have links
```ruby
  project :the_internets
    site 'http://www.google.com'
    from :feb, 1987
    # Oh, btw, :present uses Time.now
    to   :present
    summarize 'Workin with Al Gore'
    tech 'Like note, just an alias, usually used for technology used in the project'
    tech 'Enthusiasm'
  end
```

Code Samples are simple 
You put the name of your public GitHub repository and
it will figure out the link and tuck in a summary as well.
```ruby
  sample :my_repo_name, 'This is an awesome repo'
```

Schools have summary and degree, you don't put dates for the specific school
it automaticaly sets its dates to the earliest degree started to the latest degree finished.
```ruby
  school :school_of_hard_knocks
    # This should resolve BA, MBA, BS, and more...
    degree :ba
      major :lead_pipe
      major :sledgehammer
      from :jul, 1982
      to   :present
    end
    summarize "I'm a survivor."
  end
```
