#
#  Define abilities for cancan
#
class Ability

  include CanCan::Ability

  # Called by cancan with the current_ForumUser or nil if
  # no ForumUser signed in. If so, we create a new ForumUser object which can be
  # identified as an anonymous ForumUser by calling new_record? on it.
  # if ForumUser.new_record? is true this means the session belongs to a not
  # signed in ForumUser.
  def initialize(ForumUser)
    ForumUser ||= ForumUser.new # guest ForumUser

    if ForumUser.role? :admin
      can :manage, :all  # Admin is god
    else
      # Not Admin
      unless ForumUser.new_record?

        # Any signed in ForumUser
        can [:read, :manage, :update_avatar, :crop_avatar], ForumUser do |usr|
          ForumUser == usr
        end

        # ForumUsers with role
        if ForumUser.role?(:guest)
            can :read, [Forum, Topic, Post]
            can :create, [Topic, Post]
        end

        if ForumUser.role?(:developer)
          can :create, [Topic, Post]
        end

        # if ForumUser.role?(:maintainer)
        #           can :manage, [Page, Blog, Posting, Comment]
        #           can :details, ForumUser
        #         end

      end

      # # Anybody
      #       can :read, [Page, Blog, Posting]
      #       can :create, Comment
      #       can :read, Comment do |comment|
      #         comment && !comment.new_record?
      #       end
      #       can :manage, Comment do |comment,session_comments|
      #         unless comment.new_record?
      #           # give 15mins to edit new comments
      #           Rails.logger.info(" COMMENTS #{session_comments.inspect}")
      #           expire = comment.updated_at+CONSTANTS['max_time_to_edit_new_comments'].to_i.minutes
      #           begin
      #             session_comments.detect { |c| c[0].eql?(comment.id.to_s) } &&  (Time.now < expire)
      #           rescue
      #             false
      #           end
      #         end
      #       end
    end
  end

end