class ClientApplication < ActiveRecord::Base
  include OAuth::Helper
  RATINGS = [4, 9, 12]

  belongs_to :developer
  has_many :client_application_categories
  has_many :categories, :through => :client_application_categories, :source => :category

  has_many :rule_definitions
  accepts_nested_attributes_for :rule_definitions

  has_many :time_trackers

  validates_presence_of :name, :description
  validates_uniqueness_of :name
  validates_uniqueness_of :identifier

  validates_presence_of :start_age, :unless => :new_record?
  validates_presence_of :end_age, :unless => :new_record?
  validates_presence_of :icon, :unless => :new_record?
  validates_presence_of :screenshot, :unless => :new_record?
  validates_presence_of :app_store_url, :unless => :new_record?

  before_create :generate_keys

  has_attached_file :screenshot, :styles => {:default => "100x100>"}
  has_attached_file :icon, :styles => {:default => "156x156>"}

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

  def time_summary(child)
    RuleDefinition::PERIODS.keys.inject({}) do |summary, period|
      summary.merge({
                        :"game_#{period}_left_time" => child.send("#{period}_left_time", self),
                        :"total_#{period}_left_time" => child.send("total_#{period}_left_time")
                    })
    end
  end

  def click
    self.click_times ||= 0
    self.click_times += 1
    self.save
  end

  class << self

    def recommends(parent, limit=5, default_order="created_at desc")
      #find the child profile match apps

      if parent
        childes = parent.children
        if childes
          queries = []
          wheres = []

          #generate query
          #recommends by rating
#          childes.each { |child|
#            rating_range = child.rating_range
#            if rating_range
#              if not wheres.include?(age_range) and not queries.include?("rating = ?")
#                queries << "rating = ?"
#                wheres << rating_range
#              end
#            end
#          }

          #recommends by age
          age_query = "(start_age >= ? and end_age<=?)"
          childes.each { |child|
            age_range = child.age_range
            if age_range
              if not wheres.include?(age_range) and not queries.include?(age_query)
                queries << age_query
                wheres << age_range
                wheres << age_range
              end
            end
          }

          queries = queries.join(" or ") if queries
          #find recommends
          apps = ClientApplication.where([queries, *wheres]).order(default_order).limit(limit)
          return apps if apps.all #insure has recommends
        end
      end

      #if can't find parent or p.child use default
      ClientApplication.order(default_order).limit(limit)
    end

    def filters(params, page_size=15)
      #App Center Filter List
      sort_params = {"date" => "created_at desc", "update"=>"updated_at desc", "developer" => "developer_id desc"}
      sorted = sort_params[params[:sort]] || "updated_at desc"
      queries = params_to_query(params)
      ClientApplication.where(queries).order(sorted).page(params[:page]||1).per(page_size)
    end

    private
    def params_to_query(params)
      if params
        queries = []
        wheres = []
        excepts = ["controller", "action", "cookie", "session", "app", "flash", "page", "page_size", "method"]
        params.each { |key, value|
          if not excepts.include?(key)
            queries << key + "=?"
            wheres << value
          end
        }
        [queries.join(" and "), *wheres]
      end
    end

  end


end
