class FacebookController < ApplicationController
  
  def index
    YAML::load(File.open(Rails.root.join("config/facebook.yml")))
    
    
    @page = FbGraph::Page.fetch('324090001000391') 
    
  end
end
