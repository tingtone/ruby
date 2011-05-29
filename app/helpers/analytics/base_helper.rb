module Analytics::BaseHelper
  def hello
    @ss = "hello from base"
  end 
  # 
  def key_count(key,cond={})
    data = [] 
    xaxis = []  
    show_data = []              
      config_id = Admin::Statconfig.find_by_key(key).id
      all =  Stat::StatItem.all({:created_at=>{"$gte"=>Time.now.beginning_of_day}}.merge({:config_id=>config_id}))
      all.each do |item|
        data  << {:name=>8.hours.since(item.created_at).strftime("%Y年-%m月-%d %H:%M") +"-" + 8.hours.since(item.created_at).strftime("%Y年-%m月-%d %H:%M"), :y=>item.value.to_i}  
        xaxis << 7.hours.since(item.created_at).strftime("%H:%M") +"-" + 8.hours.since(item.created_at).strftime("%H:%M")  
      end                            
      show_data << {:type=>"column",:data=>data}


      return column_line("所有时间",0,key,show_data,xaxis) 
  end

  #generate the chart from the params
  # - title:
  # -  
  # -  
  # -  
  # -  
  # -  
  def column_line(title,label,data,xaxis) 
     # format the labels that show up on the chart
     pie_label_formatter = '
       function() {
         //if (this.y > 15) return this.point.name;
       }'

     # format the tooltips
     pie_tooltip_formatter = '
       function() {
         return  this.y;
       }' 

       datas = []
       data.each do |dt|
        datas << {
         :type => dt[:type],
         :data => dt[:data],
         :name => '',
         :dataLabels => {
            :enabled => true,
            :rotation=> 00,
            :color => 'red',
            :align =>'right',
            :x=> -5,
            :y => 0,
             :formatter =>' function() {
                //if (this.data.name == "line")
                // return  this.credit + ":" + this.y ; 
             }',
             :style=> {:font=>'2px' }
          }          
       }
       end  

     @chart = 
         Highchart.column({
            :chart => {
               :renderTo => "container_#{label}",
               :margin => [50, 150, 50, 60]
             },
             :credits => {
               :enabled => false
             },
             :plotOptions => {  
               :column => {
                 :cursor => 'pointer',
                 :point => {
                    :events => {
                       :click => ' function() {
                         // window.location.href="?label
                       }'
                     }
                   }, #point
                 :marker => {
                    :line_width => 0
                 },
                 :stacking=>'normal'
               } #series         
            }, #plotOptions  
           :x_axis => {  :categories => xaxis,
                 :text=>"dddd"
             },
            :y_axis => {
                 :title => {
                   :text => "Num of minutes"
                 }
            },
            :series =>    
               datas,
               :subtitle => {
               :text => ' ',
               :y => -10
             },
             :title => {
               :text => "TimeTracker"
             },
             :tooltip => {
               :formatter => pie_tooltip_formatter
             }
     }) 
     return @chart
   end
end
         
