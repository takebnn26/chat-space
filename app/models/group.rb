class Group < ApplicationRecord

  has_many :users,       through: :group_users
  has_many :messages,    dependent: :destroy
  has_many :group_users, dependent: :destroy

  validates :name, presence: true


  def last_message
    if messages.last.present?
      messages.last.image.present? ? '画像を投稿しました' : messages.last.content
    else
      'まだメッセージはありません'
    end
  end

end
