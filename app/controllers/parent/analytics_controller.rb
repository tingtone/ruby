class Parent::AnalyticsController < Analytics::BaseController
  layout "parent"    
 
  def game
    @game_app = GameApplication.find(params[:id]) 
    @game_time_chart = get_chart(@game_app)
  end  
  def education
    @edu_app = EducationApplication.find(params[:id]) 
    @edu_time_chart = get_chart(@edu_app)
  end 
  def game_top_5 
    top_5_data = current_parent.game_applications.map{|app| {:name=>app.name,:time=>app.time_trackers.sum(:time)}}.sort{|a,b| a[:time] <=> b[:time]}.reverse[0..4]
     @game_time_chart = get_top5_chart(top_5_data)
  end 
  def education_top_5 
    top_5_data = current_parent.education_applications.map{|app| {:name=>app.name,:time=>app.time_trackers.sum(:time)}}.sort{|a,b| a[:time] <=> b[:time]}.reverse[0..4]
    @edu_time_chart = get_top5_chart(top_5_data)
  end 

  protected
  def get_top5_chart(items)
    data = [] 
    xaxis = []  
    show_data = []              
     #show last 14 days
     items.each do |item|
       data  << { :name=>item[:name], :y=> item[:time]}  
       xaxis << item[:name]
     end     
    show_data << {:type=>"column",:data=>data}
    return column_line("Child Top 5","game_time",show_data,xaxis)
  end 
  def get_chart(game_app)
    data = [] 
    xaxis = []  
    show_data = []              
    data_days = game_app.time_trackers.map{|tt| tt.created_at.strftime("%m/%d")}
    #show last 14 days
    0.upto(6).each do |day|
      day = 6-day 
      this_day = day.days.ago(Time.now)
      day_str = this_day.strftime("%m/%d")
      if data_days.include?(day_str)
        time = game_app.time_trackers.sum(:time,:conditions=>["created_at >= ? and created_at <=?",this_day.beginning_of_day, this_day.end_of_day])
      else   
        time = 0
      end 
        data  << { :name=>day_str, :y=> time.to_i}  
        xaxis << day_str
    end     
    show_data << {:type=>"column",:data=>data}
    return column_line("Child Time Tracker","game_time",show_data,xaxis)
  end 

 
end
