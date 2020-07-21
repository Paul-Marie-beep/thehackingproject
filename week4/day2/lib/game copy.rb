require_relative './player.rb'

class  Game
  attr_accessor :human_player, :enemies, :player_left, :enemies_in_sight

  def initialize(name_player)
    @human_player = HumanPlayer.new(name_player)
    @enemies = get_default_enemies(4)
    @player_left = 10
    @enemies_in_sight = []
  end

  def get_default_enemies(quantity)
    result=  []
    quantity.times do |i|
      name="bot"+i.to_s
      result.push(Player.new(name))
    end
    return result
  end

  def get_random_name
    return "Player"+(1..4).map(rand(1..9)).join
  end

  def new_player_in_sight
    if @players_left == @enemies_in_sight.size
      return puts "All the players are already in sight"
    end
    key = rand(1..6)
    case key
    when (2..4)
      
    when 5,6
      
    else
      
    end
  end


  def kill_player(player)
    @enemies.delete(player)
  end

  def is_still_ongoing?
    return @human_player.life_points > 0 && 
    @enemies.any?{|x| x.life_points > 0} &&
    @enemies_in_sight.any?{|x| x.life_points > 0}
  end


  def show_players
    @human_player.show_state
    puts "There are #{@enemies.size} bots left to beat"
  end

  def menu
    @enemies.each_with_index do |e,i|
      if e.life_points >0 
        puts "#{i} - #{e.name} has #{e.life_points} life points"
      end
    end
  end


  def menu_choice
    puts " "
    puts "Which action do you want to take?"
    puts "a - Search the better weapon"
    puts "s - Search a health pack"

    puts " "
    puts "Attack a player in view "
    menu()

    print ">"
    choice = gets.chomp
    case choice
    when "a"
        @human_player.search_weapon
    when "s"
      @human_player.search_health_pack
    when ("0"..@enemies.size.to_s)
      bot = @enemies[choice.to_i]
      @human_player.attacks(bot)
      if bot.life_points <= 0
        kill_player(bot)
      end
      
    else
      puts "You need to choice only a, s or number, please try it again"
      choice = gets.chomp
    end
  end


  def enemies_attack
    puts " "
    puts "The bots attack you!"
    @enemies.each do |e|
      if @human_player.life_points > 0 && e.life_points >0
          e.attacks(@human_player)
      end
    end
  end 

  def end_game
    puts ""
    puts "*"*50
    puts @human_player.life_points > 0 ? 
    "Bravo! You win the battle!" : 
    "Lose! Game Over :("
    puts "*"*50
  end

end