class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :recipes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def self.guest
    find_or_create_by!(email: 'guest@guest.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.nickname = 'ゲスト'
      customer.self_introduction = ''
    end
  end
  # プロフィール画像
  def get_image_profile(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  #退会済みの会員が同じアカウントでログイン出来ないようにする
  def active_for_authentication?
  super && (is_deleted == false)
end 

end