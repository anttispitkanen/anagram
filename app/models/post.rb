class Post < ActiveRecord::Base
  acts_as_votable

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  scope :of_followed_users, -> (following_users) { where user_id: following_users}

  validates :user_id, presence: true
  validates :image, presence: true
  validates :caption, presence: true, length: { minimum: 3, maximum: 300 }

  has_attached_file :image, styles: { medium: "640x" } #or should it be "640px" ?
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

end
