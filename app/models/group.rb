class Group < ApplicationRecord

  has_many :users,       through: :group_users
  has_many :messages,    dependent: :destroy
  has_many :group_users, dependent: :destroy

  validates :name, presence: true

  accepts_nested_attributes_for :users

end
