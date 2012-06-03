require 'spec_helper'

describe Post do
  let(:user){FactoryGirl.create(:user)}
  before{@post = Post.new(content: "Lorem ipsum", title: "Lorem ipsum", date: Time.now.strftime("%l:%M %p, %e/%m/%Y"), author: user.full_name)}

  subject{@post}

  it{should respond_to(:content)}
  it{should respond_to(:title)}
  it{should respond_to(:date)}
  it{should respond_to(:author)}
  
end
