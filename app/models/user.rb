class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable
  devise :omniauthable, omniauth_providers: %i[discord]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid      = auth.uid
      user.username = auth.info.name
      user.email    = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
