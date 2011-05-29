module Dev::BaseHelper
  def current_game_applications
    @game_applications ||= current_developer.game_applications.all
  end

  def current_education_applications
    @education_applications ||= current_developer.education_applications.all
  end
  def hello
    return "hello"
  end
  def column_line(title,total_user,label,data,xaxis) 
    # format the labels that show up on the chart
    pie_label_formatter = '
      function() {
        if (this.y > 15) return this.point.name;
      }'

    # format the tooltips
    pie_tooltip_formatter = '
      function() {
        return "<strong>" + this.point.name + "</strong>: " + this.y + " 人";
      }'

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
                         window.location.href="?label=' + label + '&x=" + this.x;
                      }
                      ',
                    }
                  }, #point
                :marker => {
                   :line_width => 0
                }
              } #series         
           }, #plotOptions  
          :x_axis => {  :categories => xaxis,
                :text=>"dddd"
            },
           :y_axis => {
                :title => {
                  :text => "注册人数"
                }
           },
           :series => [  
                 {
                  :type => 'column',
                  :data => data,
                  :name => 'sss',
                  :dataLabels => {
                     :enabled => true,
                     :rotation=> 00,
                     :color => 'red',
                     :align =>'right',
                     :x=> -5,
                     :y => 0,
                      :formatter =>' function() {
                         return  this.y ;
                      }',
                      :style=> {:font=>'2px' }
                   }          
              } ,
              {
                :type => "line",
                :data => data,
                :name => "增长曲线图"
              }      
            ],
            :subtitle => {
              :text => ' ',
              :y => -10
            },
            :title => {
              :text => "#{title} 用户数:#{total_user}"
            },
            :tooltip => {
              :formatter => pie_tooltip_formatter
            }
    }) 
    return @chart
  end
end
