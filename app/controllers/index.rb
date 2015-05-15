enable :sessions

require 'vacuum'

get '/' do
  erb :index
end

get '/products/new' do
  erb :"products/new"
end


post '/products' do

# ******************* REFACTOR INTO HELPERS *******************************************************
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
  puts "************************************************************"
  puts output

  data = output.to_h
  @photo = data['ItemSearchResponse']['Items']['Item'].first['LargeImage']['URL']
  price_link = data['ItemSearchResponse']['Items']['Item'].first

  price = price_link['Offers']['Offer']['OfferListing']['Price']['FormattedPrice']

  price_string = price.gsub /"/, ''

  @price = price_string[1..-1].to_f

  @descriptions = price_link['ItemAttributes']['Feature']
  @name = price_link['ItemAttributes']['Title']






  # *********************************************************************************************************
  @product = Product.new(
    name: @name,
    photo: @photo,
    price: @price )

  p @product

  if @product.save
    if @descriptions
      if @descriptions[0].length == 1
        Description.create(content: @descriptions, product_id: @product.id)
      else
        @descriptions.each do |description|
          Description.create(content: description, product_id: @product.id)
        end
      end
    end

    erb :"products/show"
  else
    "Did not save.  Please be more specific."
  end
end



get '/games/new' do
  erb :"games/new"
end


post '/games' do

  @game = Game.new(player1: params[:player1], player2: params[:player2])
  if @game.save
    # session[:game_id] = @game.id
    current_game_id= @game.id

    redirect "/games/#{@game.id}/matches/new"
  else
    "WTF Bro"
  end
end

get "/games/:game_id/matches/new" do
  @product = Product.first
  @game = Game.find(params[:game_id])
  erb :"matches/new"
end



post '/games/:game_id/matches' do
  @game = Game.find(params[:game_id])

  if params[:player1_guess] > params[:player2_guess]
    message = "Player1 is the winner!"
  else
    message = "Player2 is the winner!"
  end

  match = Match.new(player1_guess: params[:player1_guess],
                    player2_guess: params[:player2_guess],
                    game_id: params[:game_id],
                    product_id: params[:product_id],
                    winner_message: message
                    )
  if match.save
    redirect "/games/#{@game.id}/matches/#{match.id}"
  else
    "WTF Bro"
  end
end


get '/games/:game_id/matches/:match_id' do
  @game = Game.find(params[:game_id])
  @match = Match.find(params[:match_id])
  erb :"matches/show"
end

# get '/matches/new' do
#   @game = Game.find(current_game_id)
#   @product = Product.last
#   # # We could make a helper that has the current game id.
#   erb :"matches/new"
# end














