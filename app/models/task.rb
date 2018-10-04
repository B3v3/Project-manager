class Task < ApplicationRecord

  belongs_to :project
  belongs_to :user, optional: true

  validates :description, presence: true, length: {minimum: 3, maximum: 150 }
  validates :project_id,  presence: true

  def assign_user(user)
    update_column(:user_id, user.id)
  end

  def unassign_user
    update_column(:user_id, nil)
  end

  def done?
    status
  end

  def not_done?
    !status
  end

  def status?
    if !self.user_assigned?
      'User not assigned!'
    elsif self.not_done?
      'In progress!'
    else
      'Done!'
    end
  end

  def user_assigned?
    !user.nil?
  end

  def complete
    update_column(:status, true)
  end
end
