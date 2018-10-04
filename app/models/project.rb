class Project < ApplicationRecord
  extend FriendlyId
    friendly_id :title, use: :slugged

  after_create  :create_invite_digest
  after_create  :add_author_to_members

  belongs_to :author, class_name: "User", foreign_key: 'user_id'

  has_many :tasks, dependent: :destroy

  has_many :memberships, class_name:'Membership', foreign_key: 'project_id',
                         dependent: :destroy

  has_many :members, through: :memberships, source: :member

  validates :title, presence: true, length: {minimum: 3, maximum: 150},
                    uniqueness: { case_sensitive: false }

  validates :description, presence: true, length: {minimum: 3, maximum: 256}

  validates :user_id, presence: true

  def add_member(user)
    Membership.create(member_id: user.id, project_id: self.id)
  end

  def kick_member(user)
    unless user == author
      memberships.find_by(member_id: user.id).destroy
    end
  end

  def is_author?(user)
    author == user
  end

  def new_token
    SecureRandom.urlsafe_base64
  end

  def create_invite_digest
    update_column(:invite_digest, self.new_token)
  end

  private
  def add_author_to_members
    add_member(self.author)
  end
end
