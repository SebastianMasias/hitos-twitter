# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  username               :string
#  image_url              :string           default("https://cdn.onlinewebfonts.com/svg/img_276187.png")
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
   acts_as_token_authenticatable

  has_many :tweets
  has_many :likes
  has_many :retweets
  # Include default devise modules. Others available are:  
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy

  has_many :passive_relationships, class_name:  "Relationship",
                                  foreign_key: "followed_id",
                                  dependent:   :destroy
  
  has_many :followings, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  # devise :invitable, :database_authenticatable,
  #        :recoverable, :rememberable, :trackable, :validatable,
  #        :lockable
  
   devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
end

