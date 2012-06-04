class FacebookController < ApplicationController
  
  def index
    YAML::load(File.open(Rails.root.join("config/facebook.yml")))
    my_app = FbGraph::Application.new(config['production']['324090001000391'])
    acc_tok = my_app.get_access_token(config['production']['785117f9e125ab08957deb100fc2cbab'])
    
    
    @page = FbGraph::Page.new(config['production']['324090001000391'], :access_token => acc_tok).fetch
    
    @posts = @page.messages
    
  end
end
