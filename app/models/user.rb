class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

        has_many :events, dependent: :destroy


  validates :email, presence: true
  # validates :name, length: { in: 1..20 }, uniqueness: true
  # validates :name_kana, length: { in: 1..20 }, uniqueness: true

end