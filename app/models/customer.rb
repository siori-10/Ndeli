class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.guest
    find_or_create_by!(email: 'guest@guest.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.nickname = 'ゲスト'
      customer.self_introduction = ''
    end
  end
  has_one_attached :profile_image
  
 has_many :recipes
 has_many :favorites, dependent: :destroy 
end