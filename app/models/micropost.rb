class Micropost < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.micropost.max_content_length}
  validate  :picture_size

  scope :micropost_desc, ->{order created_at: :desc}
  scope :feed_for, ->(user){where("user_id = ?", user.id).order created_at: :desc}
  scope :feed_status, (lambda do |user|
    Micropost.where("user_id IN (:id)
    OR user_id = :user_id", id: user.following_ids,
    user_id: user.id).order created_at: :desc
  end)

  mount_uploader :picture, PictureUploader

  private

  def picture_size
    return unless picture.size > Settings.micropost.picture_size.megabytes
    errors.add(:picture, t("micropost.picture_5MB"))
  end
end
