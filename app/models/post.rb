class Post < ActiveRecord::Base
  validates :user_id, presence: true
  validates :image, presence: true
  validates :caption, presence: true, length: { minimum: 1, maximum: 1600 }

  belongs_to :user
  has_many :comments, dependent: :destroy

  has_attached_file :image, styles: { :medium => "640x" } #or should it be "640px" ?
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end
