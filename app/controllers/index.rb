require 'vacuum'

get '/' do
	"hello world"
	request = Vacuum.new

# 	request.configure(
#     aws_access_key_id:
#     aws_secret_access_key:
#     associate_tag:
# )





  output = request.item_search(
    query: {
      'Keywords' => 'harry potter first book',
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
  # ['Offers']]['Offer']['OfferListing']

  erb :show

end
