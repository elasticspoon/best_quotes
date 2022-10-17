class QuotesController < Rulers::Controller
  def a_quote
    @test = 'crikey mate!'
    render :a_quote, noun: :winking
  end

  def exception
    raise "It's a bad one!"
  end

  def index
    render :index
  end
end