class Question < ActiveRecord::Base
  include VotesCounter
  include ActionView::Helpers::DateHelper

  has_many :comments, as: :comment_on
  has_many :votes, as: :voteable
  has_many :resource_tags, as: :taggable
  has_many :tags, through: :resource_tags
  has_many :answers
  belongs_to :user
  validates :title, presence: true
  validates :content, presence: true
  validates :user, presence: true

  def time_updated
    created = DateTime.parse(created_at.to_s).in_time_zone
    updated = DateTime.parse(updated_at.to_s).in_time_zone

    if (updated - created).to_i > 2
      return distance_of_time_in_words(updated, Time.zone.now) + " ago"
    end

    nil
  end

  def self.with_associations
    includes(:answers).includes(:user).includes(:comments)
  end

  def self.with_basic_association
    by_date.includes(:user)
  end

  def tags_to_a
    tags.pluck(:name)
  end

  def increment_views
    update(views: views + 1)
  end

  def self.with_answers
    includes(:answers)
  end
end
