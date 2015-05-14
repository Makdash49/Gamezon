require 'vacuum'

get '/' do
  redirect '/products/new'
end

get '/products/new' do
  erb :"products/new"
end


post '/products' do
  p params[:search_terms]
	request = Vacuum.new

  request.configure(
      aws_access_key_id: ENV['AMAZON_ACCESS_KEY'],
      aws_secret_access_key: ENV['AMAZON_SECRET_KEY'],
      associate_tag: ENV['AMAZON_ASSOCIATE_TAG']
  )



  output = request.item_search(
    query: {
      'Keywords' => "#{params[:search_terms]}",
      'SearchIndex' => 'All',
      'ItemPage' => '1',
      'ItemSearch.Shared.ResponseGroup' => 'Large',
    }
  )
  # This let's you see the hash reall pretty like:
  # data = output.to_h.to_json

  # This let's you access the hash:
  data = output.to_h
  @photo_link = data['ItemSearchResponse']['Items']['Item'].first['LargeImage']['URL']
  price_link = data['ItemSearchResponse']['Items']['Item'].first

  price = price_link['Offers']['Offer']['OfferListing']['Price']['FormattedPrice'].to_json

  @price = price.gsub /"/, ''


  @feature_array = price_link['ItemAttributes']['Feature']

  erb :"products/show"

end
