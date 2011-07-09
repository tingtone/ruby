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
end