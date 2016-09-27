class Micropost < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }, if: :no_image
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  
  validate  :picture_size

  private
    
    def no_image
      self.picture.nil? 
    end
    
    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
