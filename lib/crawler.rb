# 
#  crawler.rb
#  ruby
#  
#  Created by zhang alex on 2011-07-26.
#  Copyright 2011 __KittyPad.com__. All rights reserved.
# 
#  for http://itunes.apple.com/

class Crawler
  attr_accessor :uri, :agent

  def initialize(uri)
    @uri = uri
    @agent = Mechanize.new
  end #initialize

  def page
    agent.get(uri)
  end #get
  
  def links
    page.links
  end #links

  def app_name
    page.search("//div[@id='title']//h1").text
  end #app_name
  
  def app_desc
    page.search("//div[@class='product-review']//p").text
  end #app_desc
  
  def app_icon
    page.search("//div[@class='lockup product application']//img[@class='artwork']").first.attributes['src'].text
  end #app_icon
  
  def app_rated
    page.search("//div[@class='app-rating']").text
  end #app_rated
  
  def app_category
    page.search("//li[@class='genre']").text
  end #app_category
  
  def app_lang
    page.search("//li[@class='language']").text
  end #app_lang
  
  def app_requirements
    page.search("//div[@class='lockup product application']//p").text
  end #app_requirements
  
  def app_price
    page.search("//div[@class='price']").text
  end #app_price
end