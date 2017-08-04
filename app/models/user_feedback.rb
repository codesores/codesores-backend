class UserFeedback < ApplicationRecord
  belongs_to :user
  belongs_to :issue
  belongs_to :request_type

  def as_json(options={})
    super(include: [:issue])
  end
end
