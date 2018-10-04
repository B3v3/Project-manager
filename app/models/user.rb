class User < ApplicationRecord
  extend FriendlyId
    friendly_id :name, use: :slugged

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   has_many :projects, dependent: :destroy

   has_many :memberships, class_name: 'Membership', foreign_key: 'member_id',
                          dependent: :destroy

   has_many :groups, through: :memberships, source: :project

   has_many :tasks
   after_destroy :unassign_user

   VALID_NAME_REGEX = /\A[a-z0-9\-_]+\z/i
   validates :name, presence: true, length: { minimum: 3, maximum: 25 },
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_NAME_REGEX }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, allow_nil: true, length: { maximum: 199 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, allow_nil: true, length: { minimum: 6 }
  validates :password_confirmation, allow_nil: true, length: { minimum: 6 }
  
  private
    def unassign_user
      tasks.each do |task|
        task.unassign_user
      end
    end
end
