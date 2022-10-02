class HomeController < Rulers::Controller
  def index
    File.read('public/index.html')
  end
end
