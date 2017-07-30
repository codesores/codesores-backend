class Repo < ApplicationRecord
  has_many :issues
  belongs_to :language
end
