class Article < ActiveRecord::Base
  # attr_accessible :title, :body
  POSITIONS = ['EMPEROR', 'Treasurer', 'VP Internal', 'VP Social', 'VP External', 'VP Academic', 'Webmaster']
end
