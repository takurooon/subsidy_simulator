class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :omniauthable

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
     user = User.new(
       uid:      auth.uid,
       provider: auth.provider,
       email:    auth[:info][:email],
       password: Devise.friendly_token[0, 20],
       name: auth[:info][:nickname],
       icon: auth[:info][:image]
     )
     user.skip_confirmation!
     user.save
    end

    user
  end

  private

  def self.dummy_email(auth)
   "#{auth.uid}-#{auth.provider}@example.com"
  end

end
