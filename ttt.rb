require "pry"

PLAYER1 = {name: "default", marker: "X"}
PLAYER2 = {name: "default", marker: "O"}

class Player
    attr_accessor :name, :marker

    def initialize(name, marker)
        @name = name
        @marker = marker
    end

end

def intro
    puts "\n \n"
    puts "\t~~~~~~~~~~~~~~~~~~~~~~~~"
    puts "\t~~~~~Welcome~~~~~~~~~~~~"
    puts "\t~~~~~~~~To~~~~~~~~~~~~~~"
    puts "\t~~~~~~~~~~TIC~~~~~~~~~~~"
    puts "\t~~~~~~~~~~~~TAC~~~~~~~~~"
    puts "\t~~~~~~~~~~~~~~~TOE~~~~~~"
    puts "\t~~~~~~~~~~~~~~~~~~~~~~~~"
    puts "\n \n"
end



class Board 

    def initialize (p1, p2)
        @current = p1
        @opponent = p2
        @data = Array.new(3){ Array.new(3) { "~" } }
    end

    def to_s
        rows = @data.map do |row| 
            row.join(" | ")
        end
        rows.join("\n----------\n")
    end

    def valid?(move)
        if move.to_i.between?(1, 9)
            true
        else
            false
        end
    end

    def move_checker
        solicit_move
        move = gets.strip
        until valid?(move) == true
            puts "Remember, your move has to be a number between 1 and 9"
            solicit_move
            move = gets.strip.to_i
        end
        return move.to_i
    end
  
    def available?(x, y)
        x = x.to_i
        y = y.to_i
        if @data[x][y] == "~"
            return true
        else
            return false
        end
    end

    def solicit_move
        puts "#{@current.name}, please place your mark (1-9)"
    end


    def master_move(move)
        translation = {
          1 => [0,0],
          2 => [0,1],
          3 => [0,2],
          4 => [1,0],
          5 => [1,1],
          6 => [1,2],
          7 => [2,0],
          8 => [2,1],
          9 => [2,2],
        }
        x, y = translation[move]
        if available?(x, y) == true
            make_move(x, y)
        elsif available?(x, y) == false
            puts "Sorry #{@current.name}, that spot is taken."
            move = move_checker
            master_move(move)
        end
    end

    def make_move(x, y)
        @data[x][y] = @current.marker
    end


    def switch
        @current, @opponent = @opponent, @current
    end

    def no_draw?
            win_possibilities.flatten.map do |cell|
                return true if cell == "~"
            end
    end

    def winner?
        win_possibilities.each do |array|
            return true if array.all_same? == true
        end
        false
    end

    def win_possibilities
        @data + @data.transpose + diagonals
    end

    def horizontals
        @data
    end

    def verticals
        @data.transpose
    end

    def cell_location(x, y)
        @data[x][y]
    end

    def diagonals
    [ [cell_location(0,0), cell_location(1,1), cell_location(2,2)],
    [cell_location(0,2), cell_location(1,1), cell_location(2,0)] ]
    end

    def game_end
        if game_over? == :winner
            return true
        elsif game_over? == :draw
            return true
        end
    end

    def game_over?
        if winner? == true
            return :winner
        elsif no_draw? != true
            return :draw
        else
            return false
        end
    end

    def ending_text
        if game_over? == :winner
            winner_message
        elsif game_over? == :draw
            puts "\t~~~~~~~~~~~~~~~~~~~~~~~~"
            puts "\t~~~~WOMP WOMP~~~~~~~~~~~" 
            puts "\t~~~~~~~~IT\'S A TIE~~~~~~"
            puts "\t~~~~~~~~~~~~~~~~~~~~~~~~"
        end
    end
  
    def winner_message
        puts "\n"
        puts "\t~~~~~~~~~~~~~~~~~~~~~~~~"
        puts "\t~~~~~And~~~~~~~~~~~~~~~~"
        puts "\t~~~~~~~~Your~~~~~~~~~~~~"
        puts "\t~~~~~~~~~~Winner~~~~~~~~"
        puts "\t~~~~~~~~~~~~Is~~~~~~~~~~"
        puts "\t~~~~~~~~~~~~~~#{@opponent.name.upcase}~~~~~~~"
        puts "\t~~~~~~~~~~~~~~~~~~~~~~~~"
        puts "\n"
    end
end








class Array
  
    def all_same?
        spots = 0
        self.all? do |space|
            return false if space == "~"
            if space == self[0]
                spots +=1
            end
        end
        if spots >= 3
            return true
        end
    end
  
    def all_empty?
      self.all? do |space| 
        space.to_s. == "~"
      end
    end
  
    def any_empty?
      self.any? do |space| 
        space.to_s == "~"
      end
    end
  
    def none_empty?
      !any_empty?
    end
end


intro
puts "Player 1 -- please input your name."
name = gets.chomp
p1 = Player.new(name, "X")
puts "Welcome, #{p1.name}, you are now the #{p1.marker}!"
puts "\n\n"
puts "Player 2 -- please input your name."
name = gets.chomp
p2 = Player.new(name, "O")
puts "Welcome, #{p2.name}, you are now the #{p2.marker}!"
board = Board.new(p1, p2)
until board.game_end
    puts "\n"
    puts board.to_s
    puts "\n"
    move = board.move_checker
    # board.solicit_move
    # move = gets.chomp
    board.master_move(move)
    # board.make_move(move, current)
    board.switch
end
puts board.to_s
board.ending_text
# puts "GAME OVER" if(game_over?)


