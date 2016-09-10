class User < ActiveRecord::Base
  # Remember to create a migration!
  has_many :users_groups
  has_many :group_chats, through: :users_groups
  has_many :votes

  include BCrypt

  # All of the BCrypt info methods you need - can be replaced by 'has_secure_password' if the user password field is 'password_digest'

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(email, password)
    @user = User.find_by(email: email)
    if @user && @user.password == password
      @user
    else
      nil
    end
  end

end

