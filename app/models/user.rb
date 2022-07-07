class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  after_create :create_welcome

  private

  def create_welcome
    Welcome.create(user_id: self.id, placeholder: nil)
  end

end
