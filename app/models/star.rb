class Star < ApplicationRecord
  belongs_to :user
  belongs_to :issue, counter_cache: true

  def as_json(options={})
    super(include: [:issue])
  end
end
