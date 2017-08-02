class User < ApplicationRecord
  has_many :user_feedbacks
  has_many :stars

  def as_json(options={})
    super(include: [:user_feedbacks, :stars])
  end
end
