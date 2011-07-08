# init categories
ActiveRecord::Base.connection.execute("truncate categories;")

categories = %w|Books Education Game App|
categories.each do |cat|
  Category.create(name: cat)
end

# add sub categories for Education
education = Category.find_by_name "Education"
education_sub_categories = ['General Knowledge', 'Language', 'Math', 'Puzzles', 'Drawing', 'Stories', 'Music', 'Science', 'Geography', 'History']
education_sub_categories.each do |sub_cate|
  education.children.create(name: sub_cate)
end
# init categories end

# init developer





#init App



#init TimeTracker
