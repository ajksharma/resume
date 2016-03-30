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
2009 - 2010 
\par}
{\pard\ql
{\cf3
Children peed on me.
}
\par}
{\pard\ql\li400
{\cf3
\u8226\'3f Note 0.
}
\par}
{\pard\ql\li400
{\cf3
\u8226\'3f Note 1.
}
\par}
{\pard\ql\li400
{\cf3
\u8226\'3f Note 2.
}
\par}
{\pard\ql\li400
{\cf3
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
{\cf3
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
2013 
\par}
{\pard\ql
{\cf3
Navel Gazing
}
\par}
{\pard\ql\li400
{\cf3
\u8226\'3f Ruby on Rails 4.0
}
\par}
{\pard\ql\li400
{\cf3
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
{\cf3
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
<h1 class="resume-header">Mr. Test</h1><p><a href="mailto:test@test.net">test@test.net</a></p><section class="summary-section"><h2 class="resume-header">Summary</h2>
<p class="resume-summary">I am Awesome</p></section><section class="skills-section"><h2 class="resume-header">Mad Skillz</h2>
<table class="table skills-list">
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
</table></section><section class="experience-section"><h2 class="resume-header">Experience</h2>
<dl class="resume-experience">
<dt>
<p>Krusty Burger</p>
<p>2009 - 2010 </p>
</dt>
<dd class="resume-experience-position">Clown</dd>
<dd>Children peed on me.</dd>
<dd><ul class="experience-notes">
<li>Note 0.</li>
<li>Note 1.</li>
<li>Note 2.</li>
<li>Note 3.</li>
</ul></dd>
</dl></section><section class="experience-section"><h2 class="resume-header">Education</h2>
<dl class="resume-experience">
<dt><p>School Of Hard Koncks</p></dt>
<dd>Bachelor of Arts (B.A) Hulk Smash/Emo
Please Dont Hurt Me!</dd>
</dl></section><section class="experience-section"><h2 class="resume-header">Experience</h2>
<dl class="resume-experience">
<dt>
<p>RedcoratingMyHead</p>
<p>2013 </p>
</dt>
<dd>Navel Gazing</dd>
<dd><ul class="experience-notes">
<li>Ruby on Rails 4.0</li>
<li>Postgres 9.x</li>
</ul></dd>
</dl></section><section class="experience-section"><h2 class="resume-header">Code Samples</h2>
<dl class="resume-experience">
<dt><p>Resume</p></dt>
<dd>Website: <a href="http://www.github.com/bloodycelt/resume">http://www.github.com/bloodycelt/resume</a>
</dd>
<dd>The code that built this resume</dd>
</dl></section><section class="skills-section"><h2 class="resume-header">Bored Now</h2>
<table class="table skills-list"><tr>
<td>• Xkcd</td>
<td>Drawing Ven Diagrams</td>
</tr></table></section>
HERE
