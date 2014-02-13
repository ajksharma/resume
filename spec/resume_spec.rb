require 'spec_helper'

def render_with(text)
  ::PDF::Inspector::Text.analyze(::Resume::Document::Pdf.new(text).render)
end

describe 'Resume' do

  # Honestly its easier just to have it all here
  it 'should parse the dsl, and print a pdf' do
    resume = <<HERE
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
      print :skills_list, :skills,    :title => 'Mad Skillz'
      print :experience,  :jobs,      :title => 'Experience'
      print :experience,  :schools,   :title => 'Education'
      print :experience,  :projects
      print :experience,  :samples,   :title => 'Code Samples'
      print :skills_list, :hobbies,   :title => 'Bored Now'
      
HERE
      expected = [
      'Mr. Test', 
      'test@test.net', 
      'Mad Skillz', 
      '• Home Economics', 
      'Cat Throwing, SandwichMaking', 
      '• Ruby', 
      'Rspec, Blogging', 
      '• Other',
      'SnowBoarding', 
      'Experience', 
      'Clown at Krusty Burger', 
      'April 2009 - May 2010 ', 
      '( 1 year ).', 
      'Children peed on me.', 
      '• Note 0.', 
      '• Note 1.', 
      '• Note 2.', 
      '• Note 3.', 
      'Education', 
      'School Of Hard Koncks', 
      'Bachelor of Arts (B.A) Hulk Smash/Emo', 
      'Please Dont Hurt Me!', 
      'Experience', 
      'RedcoratingMyHead', 
      'January 2013 - February 2013 ', 
      '(  1 month ).', 
      'Navel Gazing', 
      '• Ruby on Rails 4.0', 
      '• Postgres 9.x', 
      'Code Samples', 
      'Resume', 'Website: ', 
      'http://www.github.com/bloodycelt/resume', 
      'The code that built this resume', 
      'Bored Now', 
      '• Xkcd', 
      'Drawing Ven Diagrams'
    ]
   
     
    render_with(resume).strings.each_with_index do |item, idx|
      expect(item).to eq(expected[idx])
    end
  end

end
