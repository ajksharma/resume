# spec/factories/resume.rb

# Mostly this file exists to stash away the giant
# resume string of DOOM!
FactoryGirl.define do

  factory :resume, :class => String do
    initialize_with { new("#{resume}" ) }
    skip_create
    
    ignore do
      resume <<'HERE'

      name 'Mr. Test'
      email 'test@test.net'

      skill 'Cat Throwing',   :under => 'Home Economics'
      skill :sandwich_making, :under => 'Home Economics'
      skill :snow_boarding
      skill :rspec,           :under => :ruby
      skill :blogging,        :under => :ruby
      
      summarize 'I am Awesome'
      
      hobby 'Drawing Ven Diagrams', :under => 'XKCD'
      
      
      job :clown, :at => :krusty_burger do
        from :apr, 2009
        to   :may, 2010 
        summarize 'Children peed on me.'
        note 'Note 0.'
        note 'Note 1.'
        note 'Note 2.' 
        note 'Note 3.'
      end
      
      project :redcorating_my_head do
        from :jan, 2013
        to   :feb, 2013
        summarize 'Navel Gazing'
        tech 'Ruby on Rails 4.0'
        tech 'Postgres 9.x'
      end

      sample :resume,   
       :summary => 'The code that built this resume', 
       :under   => :bloodycelt
      
      school :school_of_hard_koncks do
        degree :ba do
          major :hulk_smash 
          major :emo
        end
        summarize 'Please Dont Hurt Me!'
      end

      print :name
      print :email
      print :summary
      print :skills_list, :skills,    :title => 'Mad Skillz'
      print :experience,  :jobs,      :title => 'Experience'
      print :experience,  :schools,   :title => 'Education'
      print :experience,  :projects
      print :experience,  :samples,   :title => 'Code Samples'
      print :skills_list, :hobbies,   :title => 'Bored Now'
HERE

    end # ignore block
  end   # factory

  factory :rtf, :class => String do
    initialize_with { new(RTF_DOC_FACTORY) }
    skip_create
  end

  factory :html, :class => String do
    initialize_with { new(HTML_DOC_FACTORY) }
    skip_create
  end

end     # FactoryGirl

RTF_DOC_FACTORY = <<'HERE'
{\rtf1\ansi\deff0\deflang2057\plain\fs24\fet1
{\fonttbl
{\f0\froman Helvetica;}
}
{\colortbl
;
\red4\green69\blue173;
\red77\green102\blue102;
\red128\green128\blue128;
\red25\green77\blue77;
}
{\info
{\createim\yr2014\mo2\dy14\hr23\min30}
}

\paperw11907\paperh16840\margl1800\margr1800\margt1440\margb1440
{\pard\ql
{\b\fs32
Mr. Test
}
\par}
{\pard\ql
{\ul\cf1
test@test.net
}
\par}
{\pard\ql\sb240
{\b\cf2\fs28
Summary
}
\par}
{\pard\ql\fi400
I am Awesome
\par}
{\pard\ql\sb240
{\b\cf2\fs28
Mad Skillz
}
\par}
{\pard\ql
\u8226\'3f Home Economics Cat Throwing, SandwichMaking
\par}
{\pard\ql
\u8226\'3f Ruby          Rspec, Blogging
\par}
{\pard\ql
\u8226\'3f Other         SnowBoarding
\par}
{\pard\ql\sb240
{\b\cf2\fs28
Experience
}
\par}
{\pard\ql\sb160
{\b
Clown at Krusty Burger
}
\par}
{\pard\ql
April 2009 - May 2010 
{\cf3
( 1 year ).
}
\par}
{\pard\ql
{\cf4
Children peed on me.
}
\par}
{\pard\ql\li400
{\cf4
\u8226\'3f Note 0.
}
\par}
{\pard\ql\li400
{\cf4
\u8226\'3f Note 1.
}
\par}
{\pard\ql\li400
{\cf4
\u8226\'3f Note 2.
}
\par}
{\pard\ql\li400
{\cf4
\u8226\'3f Note 3.
}
\par}
{\pard\ql\sb240
{\b\cf2\fs28
Education
}
\par}
{\pard\ql\sb160
{\b
School Of Hard Koncks
}
\par}
{\pard\ql
{\cf4
Bachelor of Arts (B.A) Hulk Smash/Emo
Please Dont Hurt Me!
}
\par}
{\pard\ql\sb240
{\b\cf2\fs28
Experience
}
\par}
{\pard\ql\sb160
{\b
RedcoratingMyHead
}
\par}
{\pard\ql
January 2013 - February 2013 
{\cf3
(  1 month ).
}
\par}
{\pard\ql
{\cf4
Navel Gazing
}
\par}
{\pard\ql\li400
{\cf4
\u8226\'3f Ruby on Rails 4.0
}
\par}
{\pard\ql\li400
{\cf4
\u8226\'3f Postgres 9.x
}
\par}
{\pard\ql\sb240
{\b\cf2\fs28
Code Samples
}
\par}
{\pard\ql\sb160
{\b
Resume
}
\par}
{\pard\ql
Website: 
{\ul\cf1
http://www.github.com/bloodycelt/resume
}
\par}
{\pard\ql
{\cf4
The code that built this resume
}
\par}
{\pard\ql\sb240
{\b\cf2\fs28
Bored Now
}
\par}
{\pard\ql
\u8226\'3f Xkcd          Drawing Ven Diagrams
\par}
}
HERE

HTML_DOC_FACTORY =<<'HERE'
<h1 class="resume-header">Mr. Test</h1><p><a href="mailto:test@test.net">test@test.net</a></p><h2 class="resume-header">Summary</h2><p class="resume-summary">I am Awesome</p><h2 class="resume-header">Mad Skillz</h2><table class="table skills-list">
<tr>
<td>• Home Economics</td>
<td>Cat Throwing, SandwichMaking</td>
</tr>
<tr>
<td>• Ruby</td>
<td>Rspec, Blogging</td>
</tr>
<tr>
<td>• Other</td>
<td>SnowBoarding</td>
</tr>
</table><h2 class="resume-header">Experience</h2><ul class="resume-experience">
<h3 class="resume-header">Clown at Krusty Burger</h3>
<li>April 2009 - May 2010 <span class="time-difference">( 1 year ).</span>
</li>
<li>Children peed on me.</li>
<li><ul class="experience-notes">
<li>Note 0.</li>
<li>Note 1.</li>
<li>Note 2.</li>
<li>Note 3.</li>
</ul></li>
</ul><h2 class="resume-header">Education</h2><ul class="resume-experience">
<h3 class="resume-header">School Of Hard Koncks</h3>
<li>Bachelor of Arts (B.A) Hulk Smash/Emo
Please Dont Hurt Me!</li>
</ul><h2 class="resume-header">Experience</h2><ul class="resume-experience">
<h3 class="resume-header">RedcoratingMyHead</h3>
<li>January 2013 - February 2013 <span class="time-difference">(  1 month ).</span>
</li>
<li>Navel Gazing</li>
<li><ul class="experience-notes">
<li>Ruby on Rails 4.0</li>
<li>Postgres 9.x</li>
</ul></li>
</ul><h2 class="resume-header">Code Samples</h2><ul class="resume-experience">
<h3 class="resume-header">Resume</h3>
<li>Website: <a href="http://www.github.com/bloodycelt/resume">http://www.github.com/bloodycelt/resume</a>
</li>
<li>The code that built this resume</li>
</ul><h2 class="resume-header">Bored Now</h2><table class="table skills-list"><tr>
<td>• Xkcd</td>
<td>Drawing Ven Diagrams</td>
</tr></table>
HERE
