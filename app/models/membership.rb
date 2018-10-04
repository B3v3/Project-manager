class Membership < ApplicationRecord

  belongs_to :member, class_name: 'User'
  belongs_to :project

  validates :member_id,  presence: true
  validates :project_id, presence: true

end
