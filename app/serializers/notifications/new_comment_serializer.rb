module Notifications
  class NewCommentSerializer < CommentSerializer
    attributes :type
    # has_many :ancesr
    has_many :subscribers

    private
      def type
        'new.comment'
      end

      def root
        :notification
      end

      def subscribers
        object.participants_involved_in_comment
      end

      def ancestors
        object.parents
      end
  end
end