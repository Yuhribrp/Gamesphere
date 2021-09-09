class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :memberships, dependent: :destroy
  has_many :communities, through: :memberships
  has_many :evaluations
  has_many :gametags
  has_many :posts
  has_many :user_one_matches, class_name: 'Match', foreign_key: 'user_one_id'
  has_many :user_two_matches, class_name: 'Match', foreign_key: 'user_two_id'
  has_one_attached :photo
  has_one_attached :avatar
  after_commit :add_default_avatar, on: [:create, :update]

  validates :username, presence: true, uniqueness: true

  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: "150x150!").processed
    else
      "/default_avatar.jpg"
    end  
  end

  private

  def add_default_avatar
    unless avatar.attached?
      avatar.attach(
        io: File.open(
          Rails.root.join(
            'app', 'assets', 'images', 'default_avatar.jpg'
          )
        ), 
        filename: 'default_avatar.jpg',
        content_type: 'image/jpg'
      )
    end
  end
end
