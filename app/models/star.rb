class Star < ApplicationRecord
  belongs_to :user
  belongs_to :issue, counter_cache: true
end
