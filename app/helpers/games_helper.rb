helpers do

  def current_game_id=(id)
    session[:game_id] = id
  end

  def current_game_id
    session[:game_id]
  end

end
