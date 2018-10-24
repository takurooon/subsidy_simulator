class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :omniauthable

   def self.find_for_oauth(auth)
     user = User.where(uid: auth.uid, provider: auth.provider).first

     unless user
       user = User.create(
         uid:      auth.uid,
         provider: auth.provider,
         email:    User.dummy_email(auth),
         password: Devise.friendly_token[0, 20],
         name: auth[:info][:nickname],
         icon: auth[:info][:image]
       )
     end

     user
   end

   private

   def self.dummy_email(auth)
     "#{auth.uid}-#{auth.provider}@example.com"
   end

end
