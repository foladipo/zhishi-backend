class Question < ActiveRecord::Base
  include VotesCounter
  include ActionView::Helpers::DateHelper
  include Searchable

  has_many :comments, as: :comment_on, dependent: :destroy
  has_many :votes, as: :voteable, dependent: :destroy
  has_many :answers, dependent: :destroy
  belongs_to :user
  validates :title, presence: true
  validates :content, presence: true
  validates :user, presence: true
  has_many :resource_tags, as: :taggable
  has_many :tags, through: :resource_tags

  def time_updated
    created = DateTime.parse(created_at.to_s).in_time_zone
    updated = DateTime.parse(updated_at.to_s).in_time_zone

    if (updated - created).to_i > 2
      return distance_of_time_in_words(updated, Time.zone.now) + " ago"
    end

    nil
  end

  def self.with_associations
    eager_load(:votes).eager_load(answers: [{comments: [{user: [:social_providers]}, :votes]}, {user: [:social_providers]}, :votes]).
    eager_load(user: [:social_providers]).eager_load(comments: [{user: [:social_providers]}, :votes]).eager_load(:tags).order('answers.accepted DESC')

  end

  def self.with_basic_association
    by_date.includes(user: [:social_providers])
  end

  def increment_views
    increment!(:views)
  end

  def self.with_answers
    includes(:answers)
  end

  def as_indexed_json(options={})
    self.as_json(
      only: content_for_index,
      include: { tags: { only: :name},
                 user:    { only: [:name, :email] },
                 comments:   {
                   only: [:content],
                   include: {
                     user: {only: [:name, :email]}}
                 },
                 answers: {
                   only: [:content],
                   include: {
                     user:    { only: [:name, :email] },
                     comments:   {
                       only: [:content],
                       include: {
                         user: {only: [:name, :email]}
                       }
                     },
                   }
                 },
               }
    )
  end

  def content_for_index
    [:title, :content, :comments_count, :answers_count, :views]
  end

  def content_that_should_not_be_indexed
    [:views, :updated_at].map(&:to_s)
  end

  def sort_answers
    answers.sort do |a, b|
      if a.accepted
        -1
      elsif b.accepted
        1
      else
        b.votes_count <=> a.votes_count
      end
    end
  end
end
