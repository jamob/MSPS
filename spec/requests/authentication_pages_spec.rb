require 'spec_helper'

describe "Authentication" do

  subject{page}
    
  describe "signin page" do
    before{visit signin_path}
      
    it{should have_selector('h1',     text: 'Sign in')}
    it{should have_selector('title',  text: 'Sign in')}
  end

  describe "signin" do
    before{visit signin_path}

    describe "with invalid information" do
      before{ click_button "Sign in"}

      it{should have_selector('title', text: 'Sign in')}
      it{should have_selector('div.alert.alert-error', text: 'Invalid')}

      describe "after visiting another page" do
        before {click_link "Home"}
        it{should_not have_selector('div.alert.alert-error', text: 'Invalid')}
        end
    end

    describe "with valid information" do
      let(:user){FactoryGirl.create(:user)}
      before do
        fill_in "Name",    with: user.name
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      it {should have_selector('title', text: full_title(''))}
      it {should have_link('Profile', href: user_path(user))}
      it{should have_link('Settings', href: edit_user_path(user))}
      it {should have_link('Sign out',href: signout_path)}
      it {should_not have_link('Sign in', href: signin_path)}

      describe "posts" do
        let(:post){FactoryGirl.create(:post)}
        before{visit root_path}
        it{should have_link('New post', href: new_post_path )}
          
          describe "posting" do
            before{visit new_post_path}
            it{should have_selector('title', text: full_title('New Post'))}
            it{should have_selector('h1', text: 'New post')}
            before do
              fill_in "Title", with: "Lorem ipsum"
              fill_in "Content", with: "Dolor sit amete"
              click_button "Submit post"
            end
            it{should have_selector('title', text: full_title(''))}
            it{should have_selector('div.alert.alert-notice')}
          end


        it{should have_link('Edit', href: edit_post_path(post))}
        it{should have_link('Delete', href: post_path(Post.last))}
          it "should be able do delete a post" do
            expect{click_link('Delete')}.to change(Post :count).by(-1)
          end
      end

    end
  end

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user){FactoryGirl.create(:user)}
      let(:post){FactoryGirl.create(:post)}

      describe "in the posts controller" do
        before{visit new_post_path}
        it{should have_selector('title', text: 'Sign in')}
      end

      describe "submitting to the destroy action" do
        before{delete post_path(FactoryGirl.create(:post)) }
        specify{response.should redirect_to(signin_path)}
      end

      describe "submittint to the edit action" do
        before{visit edit_post_path(post)}
        it{should have_selector('title', text: 'Sign in')}
      end
      
      describe "in the Users controller" do
        
        describe "visiting the edit page" do
          before{visit edit_user_path(user)}
          it{should have_selector('title', text: 'Sign in')}
        end

        describe "submitting to the update action" do 
          before{put user_path(user)}
          specify{response.should redirect_to(signin_path)}
        end
      end

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Name", with: user.name
          fill_in "Password", with: user.password
          click_button "Sign in"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            page.should have_selector('title', text: 'Edit user')
          end
        end

      end
    end

    describe "as non-admin user" do
      let(:user){FactoryGirl.create(:user)}
      let(:non_admin){FactoryGirl.create(:user)}

      before{sign_in non_admin}

      describe "submitting a DELETE request to the Users#destroy action" do
        before{delete user_path(user)}
        specify{response.should redirect_to(root_path)}
      end
    end

    describe "as wrong user" do
      let(:user){FactoryGirl.create(:user)}
      let(:other_user){FactoryGirl.create(:user, name: "Wong Name")}
      before{sign_in user}

      describe "visiting Users#edit page" do
        before{visit edit_user_path(other_user)}
        it{should_not have_selector('title', text: full_title('Update your profile'))}
      end

      describe "submitting a PUT request to the User#update action" do
        before{put user_path(other_user)}
        specify{response.should redirect_to(root_path)}
      end
    end
  end
end
