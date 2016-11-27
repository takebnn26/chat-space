class Group < ApplicationRecord

  has_many :users,       through: :group_users
  has_many :messages,    dependent: :destroy
  has_many :group_users, dependent: :destroy

  validates :name, presence: true


  def last_message
    if messages.last.image.blank?
      messages.present? ? messages.last.content : 'まだメッセージはありません'
    else
      '画像を投稿しました'
    end
  end

end
