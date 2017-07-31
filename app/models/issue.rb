class Issue < ApplicationRecord
  belongs_to :repo
  has_one :language, through: :repo, source: :language
  has_many :user_feedbacks

  def as_json(options = {})
    super(include: [:repo, :language, :user_feedbacks])
  end
end
