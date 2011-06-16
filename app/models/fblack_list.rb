class FBlackList
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  referenced_in :black, :class_name => "ForumUser", :foreign_key => "black_id"
  referenced_in :user, :class_name => "ForumUser", :foreign_key => "user_id"

  index :black
  index :user

  validates_presence_of :black
  validates_presence_of :user


  class << self

    def list(user, params, page_size=20, sorted="created_at desc")
      FBlackList.where(user_id: user.id).order(sorted).page(params[:page]||1).per(page_size)
    end

  end

end