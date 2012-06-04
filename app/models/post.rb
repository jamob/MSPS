class Post < ActiveRecord::Base
  attr_accessible :content, :title, :visible, :date, :author

  validates :title, presence: true
  validates :content, presence: true
  validates :date, presence: true
  has_many :comments

  def self.search(search)
    if search
      find(:all, conditions: ['title LIKE ? OR content LIKE ?', "%#{search}%", "%#{search}"])
    else
      find(:all).reverse!
    end
  end

end
