class Message < ApplicationRecord

  belongs_to :user
  belongs_to :group

  mount_uploader :image, ImageUploader

  def change_json
    {
      content:  content,
      name:     user.name,
      date:     created_at.strftime('%Y/%m/%d %H:%M:%S'),
      image:    image.url,
    }
  end

end
