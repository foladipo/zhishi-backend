class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true
  belongs_to :user

  validates :user, presence: true
  validates :voteable, presence: true
  validates :value, presence: true

  include NotificationQueueResource


  REWARD = {
    "question_upvote" => 5,
    "answer_upvote" => 5,
    "comment_upvote" => 2,
    "question_downvote" => -2,
    "answer_downvote" => -2,
    "comment_downvote" => 0
  }

  def subscribers
    [*voteable.user]
  end

  def queue_name
    :votes_queue
  end

  def notification_key
    vote_on =voteable_type.downcase
    "#{vote_on}.#{vote_type}"
  end

  def vote_type
    case value
    when 1
      'upvote'
    when -1
      'downvote'
    when 20 # hacking this to be able to use with Answer#accept
      'accept'
    end
  end

  class << self

    def act_on_vote(operation, subject, subject_id, user)
      value = 1 if operation == "plus"
      value = -1 if operation == "minus"
      process_vote(subject, subject_id, user, value)
    end

    def process_vote(subject, subject_id, user, value)
      if subject_exists?(subject, subject_id)
        reward = store_vote(subject, subject_id, user, value)
        user = subject.find_by(id: subject_id).user
        user.update_reputation(reward) if reward

        total_votes(subject, subject_id)
      end
    end

    def store_vote(subject, subject_id, user, value)
      if subject.find(subject_id).vote_by(user)
        vote = subject_of_vote(subject, subject_id).votes.find_by(user: user)
        vote.value = value

        new_reward = vote.changed? ? evaluate_reward(false, value, subject) : false
        vote.save
      else
        subject_of_vote(subject, subject_id).votes.
          create(user: user, value: value)

        new_reward = evaluate_reward(true, value, subject)
      end

      new_reward
    end

    def subject_exists?(subject, subject_id)
      subject.exists?(id: subject_id)
    end

    def subject_of_vote(subject, subject_id)
      subject.find_by(id: subject_id)
    end

    def total_votes(subject, subject_id)
      subject_of_vote(subject, subject_id).votes.sum("value")
    end

    def evaluate_reward(new_vote, value, subject)
      key = subject.name.underscore
      reward = 0
      if new_vote
        reward = REWARD["#{key}_upvote"] if value == 1 #upvote
        reward = REWARD["#{key}_downvote"] if value == -1 #downvote
      else
        if value == 1
          reverse_downvote = REWARD["#{key}_downvote"] * -1
          reward = reverse_downvote + REWARD["#{key}_upvote"]
        elsif value == -1
          reverse_upvote = REWARD["#{key}_upvote"] * -1
          reward = reverse_upvote + REWARD["#{key}_downvote"]
        end
      end
      reward
    end
  end
end
