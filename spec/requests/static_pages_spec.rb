require 'spec_helper'

describe "Static pages" do

  let(:base_title){'MSPS'} 
  subject{page}
  
  shared_examples_for "all static pages" do
    it{should have_selector('h1', :text => heading)}
    it{should have_selector('title', text:  full_title(page_title))}
  end

  describe "Home page" do
    before{visit root_path}
    
    let(:heading) {'MSPS'}
    let(:page_title) { '' }

    it_should_behave_like "all static pages"
    it{should_not have_selector('title', :text => '| Home')}
    
    let(:user){FactoryGirl.create(:user)}
    let!(:m1){FactoryGirl.create(:post, author: user.full_name, content: "Lorem ipsum", date: Time.now.strftime("%l:%M %p, %e/%m/%Y"))}
    let!(:m2){FactoryGirl.create(:post, author: user.full_name, content: "Dolor sit amet", date: (Time.now-300).strftime("%l:%M %p, %e/%m/%Y"))}
    describe "posts" do
      it{should have_content(m1.content)}
      it{should have_content(m2.content)}
    end 
  end

  describe "Help page" do
    before{visit help_path}

    let(:heading) {'Help'}
    let(:page_title) {'Help'}

    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before{visit about_path}

    let(:heading) {'About Us'}
    let(:page_title) {'About Us'}

    it_should_behave_like "all static pages"
  end

  it "should have the right links on the layout" do
    #this goes around all the links in circular fashion
    visit root_path
    click_link "About"
    page.should have_selector 'title', text: full_title('About Us')
    click_link "Help"
    page.should have_selector 'title', text: full_title('Help')
    click_link "Contact"
    page.should have_selector 'title', text: full_title('Contact')
    click_link "Home"
    click_link "MSPS"
    page.should have_selector 'title', text: full_title('')
  end
end
