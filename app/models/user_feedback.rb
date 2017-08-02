class UserFeedback < ApplicationRecord
  belongs_to :user
  belongs_to :issue
  belongs_to :request_type
end
