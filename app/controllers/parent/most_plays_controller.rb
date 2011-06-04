class Parent::MostPlaysController < Parent::BaseController
  def index
    @most_plays = MostPlayed.order('time desc').limit(10)
  end

end
