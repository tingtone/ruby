module Analytics::BaseHelper
  #generate the chart from the params
  # - title: 
  # - label: 
  # - data
  # - xaxis   
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
         
