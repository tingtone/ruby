module ApplicationHelper

  def title page_title
    content_for(:title) { page_title }
  end #title
  
  def header &block
    content_for(:header) { yield }
  end #header
  
  def footer &block
    content_for(:footer) { yield }
  end #footer
  
  def format_price price
    if price.to_s == '0.0' || price.to_s == '0'
      "Free"
    else
      number_to_currency(price, :unit => '$')
    end
  end #format_price
  
  #Books Education Game App
  def get_categories_sub_collect
      book_cates = [["Books",1]]
      edu_cates = [["Education",2]]
      game_cates = [["Game",3]]
      app_cates = [["App",4]]
      Category.find(1).children.each do |sub_cate|
        book_cates <<  [sub_cate.name,sub_cate.id]
      end
      Category.find(2).children.each do |sub_cate|
         edu_cates <<  [sub_cate.name,sub_cate.id]
      end
      Category.find(3).children.each do |sub_cate|
         game_cates <<  [sub_cate.name,sub_cate.id]
      end
      Category.find(4).children.each do |sub_cate|
         app_cates <<  [sub_cate.name,sub_cate.id]
      end
      
      grouped_options = {
         'Books' => book_cates,
         'Education' => edu_cates,
         'Game' => game_cates,
         'App'  => app_cates
        }
      return grouped_options
    end
  
end