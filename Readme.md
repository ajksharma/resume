# Resume
The resume builder for my resume.

## What is it?
* A DSL Library to allow someone to generate a resume PDF.
* Also, has my resume in said DSL that can be generated.

## Umm... Why !!??
* I needed some decent code samples for my resume, so why not?
* And, I am the type of person that will spend a saturday coding a DSL.

## Installation
```bash
git clone https://github.com/bloodycelt/resume.git resume
cd resume
bundle install
thor resume:build resume.rl
```

## DSL

```ruby
  name  '<Your Name>'
  email '<Your email>'
```  
A skill that goes to the Ruby category.
```ruby
  skill :camel_casing, :under => :ruby
```  
Sybmols here are CamelCased for skills and titlized for :under
If you need spacing use a string
```ruby
  skill 'I Like My Spaces', :under => :whitespace
```  
If you do not specify, skills get placed into the 'Other' category.
```ruby
  skill :cat_throwing
```  
Hobbies work the same way.
```ruby
  hobby :markdown, :under => :lingua
```  
Jobs and Projects are pretty much the same with some differences.
  
Jobs require :at for employer.
```ruby
  job :programmer, :at => :hal 
    # Dates are month, year -> whatever DateTime.parse can handle for month
    from :apr, 2005
    to   :september, 2009
    summarize <<HERE
    Wrote lots of HERE documents for HAL.
HERE
    note 'A small bulleted item can go here.'
  end
```

Projects do not use :at, but have links.
```ruby
  project :the_internets
    site 'http://www.google.com'
    from :feb, 1987
    # Oh, btw, :present uses Time.now
    to   :present
    summarize 'Working with Al Gore.'
    tech 'Like note, just an alias, usually used for technology used in the project.'
    tech 'Enthusiasm'
  end
```

Code Samples are simple.
You put the name of your public GitHub repository and
it will figure out the link and tuck in a summary as well.
```ruby
  sample :my_repo_name, 'This is an awesome repo'
```

Schools have summary and degree. You don't put dates for the specific school.
It automaticaly sets its dates from the earliest degree started to the latest degree finished.
```ruby
  school :arkham_institute
    # This should resolve BA, MBA, BS, and more...
    degree :ba
      # Majors get joined with a '/' in the degree entry.
      # You can have as many as you want.
      major :computer_science
      major :computer_engineering
      from :jul, 1982
      to   :present
    end
    summarize "What is it like outside?"
  end
```
