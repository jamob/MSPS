class Post < ActiveRecord::Base
  attr_accessible :content, :title, :visible, :date, :author

  validates :title, presence: true
  validates :content, presence: true
  validates :date, presence: true

end
