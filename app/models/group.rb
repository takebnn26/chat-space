class Group < ApplicationRecord

  has_many :users,       through: :group_users
  has_many :messages,    dependent: :destroy
  has_many :group_users

  validates :name, presence: true

end
