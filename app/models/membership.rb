class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :project

  enum role: {member: 0, admin: 1}
  scope :admins, ->  {where(role: :admin)}
  scope :members, -> {where(role: :member)}
  validates :user_id, uniqueness: {scope: :project_id, message: "User has already been added to this project"}

  after_create :notify_user

  private
  def notify_user
    Rails.logger.info "User #{user.email} added to project #{project.name}"
  end
end
