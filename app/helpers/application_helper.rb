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
  
  # def support_language_options
  #     [['English', 'en'], ['Chinese', 'zh'], ['French', 'fr'], ['German', 'de'], ['Spanish', 'es'], ['Portuguese', 'pt'], ['Italian', 'it'], ['Japanese', 'ja'], ['Korean', 'ko'], ['Russian', 'ru']]
  #   end #support_language_options

  def get_categories_sub_collect
    root = Category.roots.collect{|c| [[c.name, c.id]]}
    root.each do |r|
      Category.find(r[0][1]).children.each{ |sub| r << [sub.name, sub.id] }
    end
    grouped_options = {}
    root.each{|r| grouped_options[r[0][0]] = r}
    return grouped_options
  end
  
end