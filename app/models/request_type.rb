class RequestType < ApplicationRecord
  has_many :issues
  has_many :user_feedbacks
end
