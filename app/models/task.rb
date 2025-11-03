class Task < ApplicationRecord
  belongs_to :project
  has_many :comments, as: :commentable
  validates :title, presence: true
  validates :status, inclusion: { in: %w[pending in_progress completed] }

  before_save :set_default_status

  private

  def set_default_status
    self.status ||= "pending"
  end
end
