class Issue < ApplicationRecord
  belongs_to :repo
  has_one :language, through: :repo, source: :language
end
