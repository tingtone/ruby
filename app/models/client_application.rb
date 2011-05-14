class ClientApplication < ActiveRecord::Base
  include OAuth::Helper

  belongs_to :developer
  belongs_to :device
  belongs_to :client_application_category

  validates_presence_of :name, :description
  validates_uniqueness_of :name
  validates_uniqueness_of :identifier

  before_create :generate_keys


  def as_json(options={})
    {:id => id, :name => name}
  end

  def category_name
    client_application_category.try(:name)
  end

  def generate_keys
    self.key = generate_key(16)
    self.secret = generate_key(32)
  end
end
