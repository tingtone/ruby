class Parent::MostDownloadsController < Parent::BaseController
  def index
    @most_downloads = MostDownload.order('amount desc').limit(10)
  end

end
