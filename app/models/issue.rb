class Issue < ApplicationRecord
  belongs_to :repo
  has_one :language, through: :repo, source: :language
  has_many :user_feedbacks
  has_one :request_type


  def as_json(options = {})
    super(include: [:repo, :language, :user_feedbacks])
  end

  def self.advanced_search(difficulty_input, request_type_id, language_id)
    # Grab issues that match language and request_type param
    first_results = Issue.where(request_type_id: request_type_id)

    second_results = first_results.select do |issue|
      issue.repo.language.id == language_id
    end

    # Grab issues that are considered valid
    third_results = second_results.select do |issue|
      valid_scores = issue.user_feedbacks.pluck(:validity)
      valid_scores.count > 15 && (valid_scores.sum.to_f / valid_scores.count.to_f) <= 0.3
    end

    # Grab issues that are less than or equal to the user's target difficulty level
    final_results = third_results.select do |issue|
      difficulty_scores = issue.user_feedbacks.pluck(:difficulty)
      (difficulty_scores.sum.to_f / difficulty_scores.count.to_f) <= difficulty_input
    end

    # return the sorted results
    final_results
  end


  private
  # def self.valid_issue
  #   valid_issues = []
  #   Issue.all.each do |issue|
  #     valid_scores = issue.user_feedbacks.pluck(:validity)
  #     if !(valid_scores.count > 15 && get_average(valid_scores) <= 0.3)
  #       valid_issues << issue
  #     end
  #   end
  #   valid_issues
  # end
  #
  # def self.difficulty_mean(difficulty_input)
  #   difficulty_issues = []
  #   Issue.all.each do |issue|
  #     difficulty_scores = issue.user_feedbacks.pluck(:difficulty)
  #     if get_average(difficulty_scores) <= difficulty_input
  #       difficulty_issues << issue
  #     end
  #   end
  #   difficulty_issues
  # end
  #
  # def self.by_request_type(request_type_input)
  #   Issue.where(request_type_id: request_type_input)
  # end

  # def get_average(arr)
  #   arr.inject{ |sum, el| sum + el }.to_f / arr.size
  # end

end
