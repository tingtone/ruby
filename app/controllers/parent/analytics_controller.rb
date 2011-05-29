class Parent::AnalyticsController < Analytics::BaseController
  layout "parent"    
  def index
    @s = hello
  end
  
  def show
    @game_app = GameApplication.find(params[:id]) 
    @game_time_chart = get_chart(@game_app)
  end  
  
  
  
  protected
  def get_chart(game_app)
    data = [] 
    xaxis = []  
    show_data = []              
    data_days = game_app.time_trackers.map{|tt| tt.created_at.strftime("%m/%d")}
    #show last 14 days
    0.upto(6).each do |day| 
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
