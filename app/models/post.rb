class Post < ActiveRecord::Base

  validates :image, presence: true
  validates :caption, presence: true, length: { minimum: 1, maximum: 1600 }
                                                #or should it be "640px" ?
  has_attached_file :image, styles: { :medium => "640x" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end
