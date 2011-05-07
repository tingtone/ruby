class ClientApplication < ActiveRecord::Base
  include OAuth::Helper

  belongs_to :developer

  before_create :generate_keys

  def generate_keys
    self.key = generate_key(16)
    self.secret = generate_key(32)
  end
end
