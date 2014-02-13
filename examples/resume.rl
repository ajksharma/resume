
background                'images/straws.png'
name                      'Jason Kenney'
email                     'therealjasonkenney@gmail.com'

skill 'Rails 3..4.x',     :under => :ruby
skill :prawn,             :under => :ruby
skill :rspec,             :under => :ruby
skill :capistrano,        :under => :ruby
skill :rack,              :under => :ruby
skill :chef,              :under => :ruby

skill :perl

skill :j_query,           :under => 'Javascript/CSS'
skill :angular_j_s,       :under => 'Javascript/CSS'

skill :sql_server,        :under => :databases
skill :postgres,          :under => :databases
skill 'SOLR (Lucene)',    :under => :databases

skill :git,               :under => :tools
skill :subversion,        :under => :tools
skill :vi,                :under => :tools
skill :omnigraffle,       :under => :tools
skill :visio,             :under => :tools
skill 'JIRA',             :under => :tools

skill 'XSLT'
skill 'Apache FOP'
skill 'Control-M'
skill :c
skill 'GLSL'
skill 'IPC'
skill :lisp
skill 'LaTeX'

summarize <<HERE
Jason Kenney was born in the small land of Rhode Island, den of thieves. After eighteen years of imprisonment in the shamefully small state he received his letter from the Hartford School of Witchcraft and Wizardry.
There he was taught the arcane knowledge of names and symbols of power, of registers and apis, of mystical languages. Of Perl: the language of the gods, which if read can drive one mad.
After finishing his apprenticeship, Jason Kenney went on many boring adventures in the wonderful land of IT. (Rumors of his involvement with the Patchwork Girl are unsubstantiated).
HERE

job :programmer, :at => :liaison_international do
  from :april, 2009
  to   :present 
  summarize 'Full stack developer responsible for the development and support of several web portals for admissions.'
  note 'Designed and implemented a change management process and workflow using Git, and Jira, documented with Omnigraffle.'
  note 'Refactored the financial reporting libraries in 22 applications into one single library.'
  note 'Built and maintained two web applications for college admissions (AACPMAS and Nursing).'
  note 'Designed, modeled, and architected a brand new service for tracking psychology hours.'
  note 'Hacked capistrano to work with our legacy perl applications.'
  note 'Rebuilt our ruby servers to leverage Chef and Bluepill.'
  note 'Mentored (and tolerated) junior programmers.'
  note 'Beat coworkers at Diplomacy'
end 

job :release_engineer, :at => :accenture_technology_solutions do
  from :july, 2005
  to   :feb,  2009
  summarize 'Watchdog and enforcer of change management processes (and Sarbanes-Oxley)'
  note 'Designed and implemented a change management process and workflow using Harvest, and Clearquest, documented with Visio.'
  note 'Built the migration script to move packages from Harvest to Oracle in Perl.'
  note 'Designed the Job Process flow for the Nightly ETL using Control-M and Visio.'
end

job :educational_technologist, :at => 'University of Hartford FCLD (Work-Study)' do
  from  :sep, 2004
  to    :may, 2005
  summarize 'Helped faculty acclimate to blackboard, and assited with adminstrative tasks.'
end

project 'WebADMIT' do
  from :jan, 2014
  to   :present
  summarize 'Admissions portal for Colleges, aggregates data from 30+ CAS services'
  tech 'Ruby on Rails 3.0'
  tech 'Postgres 8.x'
end

project :my_psych_track do
  site 'http://portal.mypsychtrack.com'
  from :mar, 2012
  to   :dec, 2014
  summarize 'A web portal that helps psychology students track their "hours".'
  tech 'Apache SOLR'
  tech 'Ruby on Rails 3.2'
  tech 'Postgres 9.1'
end

project 'NursingCAS' do
  site 'http://portal.nursingcas.org'
  from :oct, 2009 
  to   :feb, 2014 
  summarize 'A web portal that allows for application to multiple schools in the field of Nursing (AACN).'
  tech 'Perl 5.8'
  tech 'CGI::Application'
  tech 'M$ SQL Server 2005'
  tech 'AngularJS'
end 

project 'CAS Financial Reporting Library' do
  from :apr, 2011
  to   :apr, 2012
  summarize 'Core CAS Library for Financial Reporting, used in 12+ services.'
  tech 'Perl 5.8'
  tech 'CGI::Application'
  tech 'M$ SQL Server 2005'
end 

project 'AACPMAS' do
  site 'http://portal.aacpmas.org'
  from :apr, 2009
  to   :oct, 2010
  summarize 'A web portal for Podiatry Admissions'
  tech 'Perl 5.8'
  tech 'CGI::Application'
  tech 'M$ SQL Server 2005'
end 

project 'Synergy' do
  from :oct, 2005
  to   :feb, 2009
  summarize 'A Major Financial Reporting Project involving an ETL, several warehouses, BI and a Historical warehouse.'
  tech 'Informatica'
  tech 'Control-M' 
  tech 'Oracle 9i, 10g, 11.03, 11i'
  tech 'Java'
  tech 'Kalido'
  tech 'Shareplex' 
  tech 'Microsoft Powerpoint'
end

sample :function, 
       :summary => 'A Ruby gem that mimics Python functions', 
       :under   => :bloodycelt

sample :resume,   
       :summary => 'The code that built this resume', 
       :under   => :bloodycelt

school :university_of_hartford do
  degree :ba do
    major :computer_science 
    major :creative_writing
  end
  summarize 'Activities and Societies: University of Hartford Sci-Fi/Fantasy Guild (V.P)'
end

hobby :medieval,                :under => :literature
hobby :postmodern,              :under => :literature
hobby 'Mythology and Folklore', :under => :literature
hobby :kurosawa,                :under => :film
hobby :animation,               :under => :film

hobby 'Code Spelunking'
hobby 'Digital Photography'
hobby 'Interactive Media'
hobby :hiking

print :name
print :title
print :email
print :skills_list, :skills,    :title => 'Meta'
print :summary
print :experience,  :jobs,      :title => 'Experience'
print :experience,  :projects
print :experience,  :samples,   :title => 'Code Samples'
print :experience,  :schools,   :title => 'Education'
print :skills_list, :hobbies,   :title => 'Hobbies/Interests'
