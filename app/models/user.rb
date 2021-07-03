class User < ApplicationRecord
  before_update :not_nullify_admin
  before_destroy :least_one
  before_validation { email.downcase! }
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, if: lambda{ new_record? || !password.nil? }
  has_many :tasks, dependent: :destroy

  private
  def not_nullify_admin
    throw(:abort)  if User.where(admin: true).count == 1 && self.admin == false
  end
  def least_one
    throw(:abort) if User.where(admin: true).count == 1 && self.admin
  end
end

# def validates(colomn_name, length:, presence: true, if:)
#   self.update if if.nil? || if(self)
# end
# def sample(a, b, c)
# end
# sample(1, 2)
