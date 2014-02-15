require 'spec_helper'
require 'factories'

describe 'Resume' do

  before(:all) do
    @resume = FactoryGirl.create(:resume)
  end

  it 'should parse the dsl and print an html' do
    puts ::Resume::Document::Html.method(:new).owner
    doc = ::Resume::Document::Html.new(@resume)

    expect("#{doc.to_html}\n").to eq(FactoryGirl.create(:html))
  end 

  it 'should parse the dsl and print an rtf' do

    doc = ::Resume::Document::Rtf.new(@resume, RTF::Font.new(RTF::Font::ROMAN, 'Helvetica'))
    
    # For testing set creation date to the factory.
    # Also appended a newline, as HERE docs do that, and
    # M$ breaks UNIX convention by NOT Ending a text documnent
    # with a newline.
    doc.information.created = '2014-02-14 23:30'
    expect("#{doc.to_rtf}\n").to eq(FactoryGirl.create(:rtf))
    
  end

  # PDF Inspector allows you to access an array of all strings
  # from the pdf. This is the only way to determine if the pdf
  # generates with the content, obviously generating an actual
  # pdf is the only real way to match it.
  context 'it should parse the dsl, print the pdf and' do
    before do
      @resume_strings = ::PDF::Inspector::Text.analyze(
        ::Resume::Document::Pdf.new(@resume).render ).strings
    end

    # This should get put into a factory maybe?
    [ 'Mr. Test', 
      'test@test.net', 
      'Summary',
      'I am Awesome',
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
    ].each_with_index do |item, idx|
        
      it "should contain '#{item} at #{idx}'" do
        expect(@resume_strings[idx]).to eq item
      end
    end # loop
  end # context
end # describe
