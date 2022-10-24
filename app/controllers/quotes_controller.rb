class QuotesController < Rulers::Controller
  def a_quote
    @test = 'crikey mate!'
    render :a_quote, noun: :winking
  end

  def exception
    raise "It's a bad one!"
  end

  def index
    quotes = FileModel.all
    render :index, quotes: quotes
  end

  def quote_1
    quote_one = FileModel.find(1)
    render :quote, obj: quote_one
  end

  def new_quote
    attrs = {
      'submitter' => 'web user',
      'quote' => 'a picture is worth a thousand words',
      'attribution' => 'me'
    }

    m = FileModel.create attrs
    render :quote, obj: m
  end
end