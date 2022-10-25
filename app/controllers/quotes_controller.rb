require 'uri'
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

  def update_quote
    return '' unless env['REQUEST_METHOD'] == 'POST'
    file = FileModel.find(1)
    file["quote"] = ('a'..'z').to_a.shuffle[0,8].join
    file.save
    ''
  end

  def submitter_index
    submitters = FileModel.all.map { |model| model['submitter'] }.uniq

    render :submitter_index, submitters: submitters
  end

  def submitter_quotes
    submitters = query_params['submitter']
    return index unless submitters

    quotes = submitters.inject([]) do |arr, val| 
      arr + FileModel.find_all_by_submitter(val) 
    end.compact

    render :index, quotes: quotes
  end

  private

  def submitters_list
    all.map { |model| model['submitter'] }.uniq
  end

  def query_params
    return {} unless env['QUERY_STRING']
    inputs = env['QUERY_STRING']&.split('&')

    inputs.inject({}) do |hash, pair| 
      k, v = pair.split('=')
      puts CGI.unescape(v).inspect
      (hash[k] ||= []) << CGI.unescape(v)
      hash
    end    
    # Hash[URI.decode_www_form(env['QUERY_STRING'])]
  end
end