class ClientApplication < ActiveRecord::Base
  include OAuth::Helper

  belongs_to :developer
  belongs_to :device

  before_create :generate_keys

  def as_json(options={})
    {:id => id, :name => :name}
  end

  def generate_keys
    self.key = generate_key(16)
    self.secret = generate_key(32)
  end
end
