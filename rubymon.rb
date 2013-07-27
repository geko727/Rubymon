X = 60
#60% probabilidades de Batalla

class Rubymon
	attr_accessor :name, :level, :special, :hp, :hp2

	def initialize(name, level, special, hp)
		@name = name
		@level = level
		@special = special
		@hp = hp
		@hp2 = hp
	end

	def show
		puts name
		puts level
		puts special
		puts hp
	end
end

class Initialmon < Rubymon
end

class Enemy < Rubymon
end

class Player
	attr_accessor :name, :score, :battles

	def initialize(name)
		@name = name
		@score = 0
		@battles = {"W" => 0, "L" => 0, "S" => 0}
	end

	def show
		puts name
		puts score
		puts battles["W"]
	end
end


class Game
	attr_accessor :player, :name
	def initialize	; end

	def start
		createrubymons
		puts "--Hi there! "
		puts "--What's your name?"
		@name = gets.chomp
		@player = Player.new(@name)
		show
	end

	def createrubymons
		@pika = Initialmon.new("Pikachu", 1, "ThunderBolt", 10)
		@charma = Initialmon.new("Charmander", 1, "BabyFlame", 10)
		@bulba = Initialmon.new("Bulbasaur", 1, "PowerWhip", 10)
	end

	def show
		puts
		puts "Hi #{player.name}, Welcome to the Rubymon World!!"
		puts "You could choose one of the Rubymons that we have to you!!!!"
		puts "------------------------------------------------------------"
		puts "1.-Name: #{@pika.name}, Special Ability: #{@pika.special}"
		puts "2.-Name: #{@charma.name}, Special Ability: #{@charma.special}"
		puts "3.-Name: #{@bulba.name}, Special Ability: #{@bulba.special}"
		puts "------------------------------------------------------------"
		puts "Make your choice"
		@choice = gets.chomp
		choose(@choice)
	end

	def choose(choice)
		while choice != '1' && choice != '2' && choice != '3'
			puts "Please enter a valide option --1, --2 or --3"
			choice = gets.chomp
		end
		puts
		puts "You have choosen..."
		if choice == '1'
				puts "#{@pika.name}!!!!!"
				@friend = @pika
			elsif choice == '2'
				puts "#{@charma.name}!!!!!"
				@friend = @charma
			elsif choice == '3'
				puts "#{@bulba.name}!!!!!"
				@friend = @bulba
		end
		puts "Let's start our journey"
		@loses_count = 0 
		adventure(@friend)
	end	

	def adventure(friend)
		puts 
		puts
		puts "You can walk across the entire world"
		choosedirection
	end

	def choosedirection
		puts "Please choose a direction or stand"
		puts "1-North     2-South     3-East     4-West     5-Stand"
		direction = gets.chomp
		while direction != '1' && direction != '2' && direction != '3' && direction != '4' && direction != '5'
			puts "Please enter a valide option --1, --2... --5"
			direction = gets.chomp
		end
		if direction == '5'
			puts "You decided to stand"
			choosedirection
		else
			probability
			if @c == 1 
				battle
			elsif @c == 2
				nothing
			end
		end
	end

	def stand
		puts "#{player.name} decided to stand"
		choosedirection
	end

	def battle
		puts
		puts "Here comes a new challenger!!!"
		create_enemy
		puts
		puts "Enemy's Rubymon"
		puts "#{@enemy.name}     Level: #{@enemy.level}     SpecialMove: #{@enemy.special}     HP= #{@enemy.hp}"
		puts
		puts "--------------------------------------------------------------------------------------------------"
		puts
		puts "#{@player.name}'s Rubymon"
		puts "#{@friend.name}     Level: #{@friend.level}     SpecialMove: #{@friend.special}     HP= #{@friend.hp}"
		puts
		choose_action
	end

	def choose_action
		puts
		puts "You have to choose a move"
		puts "1-Attack     2-Defense     3-SpecialMove     4-Run"
		action = gets.chomp
		puts
		while action != '1' && action != '2' && action != '3' && action != '4'
			puts "Please enter a valide option --1, --2... --4"
			action = gets.chomp
		end
		if action == '1'
			attack 
		elsif action == '2' 
			defense
		elsif action == '3'
			special_move
		else
			run
		end
	end

	def run 
		puts "You have run from the battle"
		@player.battles["S"] += 1
		puts "#{@player.battles["S"]}"
		choosedirection
	end

	def attack
		if @evil_defense
			prng = Random.new
			e = prng.rand(1..2)
			if e == 1 
				puts "#{@friend.name} attacks!!!"
				@enemy.hp -= 1
				if @enemy.hp <= 0
					win
				end
				puts "#{@enemy.name}'s hp = #{@enemy.hp}"
			else 
				puts "#{@friend.name} attacks!!!"
				puts "#{@friend.name}'s attack don't have effect"
			end
			@evil_defense = false
			enemy_action
		end
		puts "#{@friend.name} attacks!!!"
		@enemy.hp -= 2
		if @enemy.hp <= 0
			win
		end
		puts "#{@enemy.name}'s hp = #{@enemy.hp}"
		@evil_defense = false
		enemy_action
	end

	def win
		puts "#{@player.name} win the battle!!! #{@friend.name}'s HP increases by 1"
		puts
		@friend.hp2 += 1
		@friend.level += 1
		choosedirection
	end

	def defense
		@friend_defense = true
		puts "#{@friend.name} choose defense"
		@evil_defense = false
		enemy_action
	end

	def special_move
		if @evil_defense
			prng = Random.new
			e = prng.rand(1..2)
			if e == 1 
				puts "#{@friend.name} use #{@friend.special}"
				@enemy.hp -= 2
				if @enemy.hp <= 0
					win
				end
				puts "#{@enemy.name}'s hp = #{@enemy.hp}"
			else 
				puts "#{@friend.name} use #{@friend.special}"
				puts "#{@friend.name}'s attack don't have effect"
			end
			@evil_defense = false
			enemy_action
		end

		puts "#{@friend.name} use #{@friend.special}"
		@enemy.hp -= 4
		if @enemy.hp <= 0
			win
		end
		puts "#{@enemy.name}'s hp = #{@enemy.hp}"
		@evil_defense = false
		enemy_action
	end

	def enemy_action
		prng = Random.new
		f = prng.rand(1..3)
		if f == 1
			enemy_attack
		elsif f == 2
			enemy_defense
		elsif f == 3
			enemy_special
		end
	end

	def enemy_attack
		if @friend_defense
			prng = Random.new
			e = prng.rand(1..2)
			if e == 1 
				puts "#{@enemy.name} attacks!!!"
				@friend.hp -= 1
				puts "#{@friend.name}'s hp = #{@friend.hp}"
			else 
				puts "#{@enemy.name} attacks!!!"
				puts "#{@enemy.name}'s attack don't have effect"
			end
			@friend_defense = false
			choose_action
		end
		puts "#{@enemy.name} attacks!!!"
		@friend.hp -= 2
		if @friend.hp <=0
			lose
		end
		puts "#{@friend.name}'s hp = #{@friend.hp}"
		@friend_defense = false
		choose_action
	end

	def lose 
		puts "#{@player.name} loses the battle, #{@friend.name}'s level decreses by 1"
		puts
		@friend.hp = @friend.hp2
		if @friend.level > 1
		@friend.level -= 1
		end
		@loses_count += 1
		if @loses_count == 3
			game_over
		end
		puts @loses_count
		choosedirection
	end

	def game_over
		puts "Sorry, #{player.name} have lost 3 battles, #{player.name} has to leave Rubymon world"
		puts "See you soon!!!"
		abort("bye bye")
	end

	def enemy_defense
		@evil_defense = true
		puts "#{@enemy.name} choose defense"
		@friend_defense = false
		choose_action
	end

	def enemy_special
		if @friend_defense
			prng = Random.new
			e = prng.rand(1..2)
			if e == 1 
				puts "#{@enemy.name} use #{@enemy.special}"
				@friend.hp -= 2
				puts "#{@friend.name}'s hp = #{@friend.hp}"
			else 
				puts "#{@enemy.name} use #{@enemy.special}"
				puts "#{@enemy.name}'s attack don't have effect"
			end
			@friend_defense = false
			choose_action
		end
		puts "#{@enemy.name} use #{@enemy.special}"
		@friend.hp -= 4
		if @friend.hp <= 0
			lose
		end
		puts "#{@friend.name}'s hp = #{@friend.hp}"
		@friend_defense = false
		choose_action
	end

	def create_enemy
		@a = @friend.level
		enemylevel(@a)
		@enemy = Rubymon.new("EvilRubymon", @lev, "EvilShadow", 10)
	end

	def enemylevel(a)
		if a == 1
			prng = Random.new
			a = prng.rand(1..3)
			@lev = a
		elsif a == 2 
			prng = Random.new
			a = prng.rand(1..4)
			@lev = a
		elsif a == 10 
			prng = Random.new
			a = prng.rand(8..10)
			@lev = a
		else
			prng = Random.new
			min = a - 2
			max = a + 2
			a = prng.rand(min..max)
			@lev = a 
		end
		@lev
	end


	def nothing
		puts "Nothing happens..."
		choosedirection
	end

	def probability
		a = 100
		b = rand(a)
		if b <= X 
			@c = 1
			#battle
		else 
			@c = 2
			#nothing
		end
		@c
	end
end


gam = Game.new
gam.start

