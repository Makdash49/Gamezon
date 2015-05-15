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
      aws_access_key_id: AMAZON_ACCESS_KEY,
      aws_secret_access_key: AMAZON_SECRET_KEY,
      associate_tag: AMAZON_ASSOCIATE_TAG
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
  @game = Game.find(params[:game_id])
  index = @game.product_index
  product_count = Product.count

  if index < product_count
    @product = Product.all[index]
    @game.product_index += 1
    @game.save
    erb :"matches/new"
  else
    if @game.player1_score > @game.player2_score
      @message = "#{@game.player1} is the Winner!"
    elsif @game.player2_score > @game.player1_score
      @message = "#{@game.player2} is the Winner!"
    else
      @message = "It's a tie!"
    end

    erb :"games/show"
  end
end



post '/games/:game_id/matches' do
  @game = Game.find(params[:game_id])
  @product = Product.find(params[:product_id])

  @player1_guess = params[:player1_guess].to_i
  @player2_guess = params[:player2_guess].to_i

  @guess1diff = @product.price - params[:player1_guess].to_i
  @guess2diff = @product.price - params[:player2_guess].to_i

  puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
  p @player1_guess
  p @player2_guess

  if @player1_guess == 0 && @player2_guess == 0
    message = "You both forgot to bid!  No winner!"
  elsif @player1_guess > @product.price && @player2_guess > @product.price
    message = "You both over bid! No winner!"
  elsif @player1_guess > @product.price && @player2_guess <= @product.price
    @game.player2_score += 1
    @game.save
    message = "#{@game.player2} wins!"
  elsif @player2_guess > @product.price && @player1_guess <= @product.price
    @game.player1_score += 1
    @game.save
    message = "#{@game.player1} wins!"
  elsif @guess1diff < @guess2diff
    @game.player1_score += 1
    @game.save
    message = "#{@game.player1} wins!"
  elsif @guess1diff > @guess2diff
    @game.player2_score += 1
    @game.save
    message = "#{@game.player2} wins!"
  elsif @player2_guess == @player1_guess
    message = "You both bid the same! No winner!"
  end

  # Ok.  So we want to subtrack the guesses from the product price.
  # Say the price is 6.00.  If player1 guessed 3 dollars, this difference
  # is 3 dollars.  If player2 guessed 4 dollars, the difference is 2 dollars.
  # Player two wins because the difference is less.  Now if one player overbid
  # then that player lost provided the other player did not overbid.
  # If they both over bid then they should both have to guess again, or they
  # both lose and no one wins the price.

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















