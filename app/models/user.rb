class User < ActiveRecord::Base
  has_many :tweets
  has_many :comments
  mount_uploader :avatar, AvatarUploader

  has_secure_password

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.password = auth.credentials.token
      user.password_confirmation = auth.credentials.token
      user.name = auth.info.name
      user.handle = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

end
