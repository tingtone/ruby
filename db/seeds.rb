ActiveRecord::Base.connection.execute("truncate categories;")

categories = %w|Books Education Game App|
categories.each do |cat|
  Category.create(name: cat)
end


