class Bonus < ActiveRecord::Base
  TIME = 15
  EXPIRE_WEEKS = 12

  belongs_to :child

  before_save :init_time_and_expired_on
  after_save :update_parent_timestamp
  after_destroy :update_parent_timestamp

  def as_json(options={})
    {:time => time, :expired_on => expired_on.to_time.to_i, :child_id => child.id}
  end

  protected
    def init_time_and_expired_on
      self.time ||= TIME
      self.expired_on ||= Date.today.since(EXPIRE_WEEKS.weeks)
    end

    def update_parent_timestamp
      child.parent.update_attribute(:bonus_updated_at, self.updated_at)
    end
end
