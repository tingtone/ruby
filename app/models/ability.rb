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
  def initialize(forum_user)
    forum_user ||= ForumUser.new # guest ForumUser

    if forum_user.role? :admin
      can :manage, :all  # Admin is god
    else
      # Not Admin
      unless forum_user.new_record?

        # Any signed in ForumUser
        can [:read, :manage, :update_avatar, :crop_avatar], ForumUser do |usr|
          forum_user == usr
        end

        # ForumUsers with role
        if forum_user.role?(:guest)
          can :read, [Forum, Topic, Post]
          can :create, [Topic, Post]
        end

        if forum_user.role?(:developer)
          can :create, [Topic, Post]
        end
      end

      # Anybody
      can :read, [Forum, Topic, Post]
      can :create, Post
      can :read, Post do |post|
        post && !post.new_record?
      end

      can :manage, Post do |post, session_posts|
        unless post.new_record?
          expire = post.updated_at+CONSTANTS['max_time_to_edit_new_comments'].to_i.minutes
          begin
            session_posts.detect{|p| p[0].eql?(post.id.to_s) } && (Time.now < expire)
          rescue
            false
          end
        end
      end
    end

  end
end

