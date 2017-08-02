class Issue < ApplicationRecord
  include PgSearch

  belongs_to :repo
  has_one :language, through: :repo, source: :language
  has_many :user_feedbacks
  has_one :request_type
  has_many :stars

  pg_search_scope :search_all_text, against: [:title, :labels, :repo_name, :body, :author], using: { tsearch: { any_word: true } }

  scope :most_recent, -> (limit) { order("issue_created_at DESC").limit(limit) }

  def self.hot_issues
    order('stars_count DESC').limit(10)
  end

  def as_json(options = {})
    super(include: [:repo, :language, :user_feedbacks, :stars])
  end

  class << self

    def filter_validity(issue_array)
      issue_array.reject do |issue|
        valid_scores = issue.user_feedbacks.pluck(:validity)
        valid_scores.count > 15 && (valid_scores.sum.to_f / valid_scores.count.to_f) <= 0.3
      end
      return issue_array
    end

    def filter_language(language, issue_array)
      if language != ""
        language_id = Language.find_by(language: language).id
        results = issue_array.select do |issue|
          issue.repo.language.id == language_id
        end
        return results
      else
        return issue_array
      end
    end

    def filter_request_type(bugs, documentation, issue_array)
      results = issue_array
      results = results.reject { |issue| issue.request_type_id == RequestType.find_by(scope: 'bug').id } if bugs == false
      results = results.reject { |issue| issue.request_type_id == RequestType.find_by(scope: 'docs').id } if documentation == false
      return results
    end

    def filter_difficulty(difficulty_input, issue_array)
      if difficulty_input > 0
        results = issue_array.select do |issue|
          difficulty_scores = issue.user_feedbacks.pluck(:difficulty)
          (difficulty_scores.sum.to_f / difficulty_scores.count.to_f).ceil == difficulty_input
        end
        return results
      else
        return issue_array
      end
    end

    def advanced_search(bugs, documentation, language, difficulty_input, search_term)

      if search_term != ""
        search_issues = Issue.search_all_text(search_term)
      else
        search_issues = Issue.all
      end

      valid_issues = filter_validity(search_issues)

      valid_lang = filter_language(language, valid_issues)

      valid_lang_request = filter_request_type(bugs, documentation, valid_lang)

      valid_lang_request_difficulty = filter_difficulty(difficulty_input, valid_lang_request)

      return valid_lang_request_difficulty
    end
  end
end
