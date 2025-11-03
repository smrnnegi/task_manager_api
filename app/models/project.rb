class Project < ApplicationRecord
  belongs_to :user    #owner or member
  has_many :memberships, dependent: :destroy
	has_many :members, through: :memberships, source: :user
	has_many :comments, as: :commentable

  has_many :tasks, dependent: :destroy
	validates :name, presence: true, length: { minimum: 3 }
  validates :description, length: { maximum: 500 }

  # Example callback — log something after creation
  after_create :log_project_creation

  private

  def log_project_creation
    Rails.logger.info "New project created: #{name}"
  end

end
