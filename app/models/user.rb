class User < ApplicationRecord
  has_many :user_feedbacks
  def as_json(options={})
    super(include: [:user_feedbacks])
  end
end
