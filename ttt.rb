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

module TicTacToe
    def player_creation
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
    end
end
class Cell 
    attr_accessor :marker
    def initialize(marker = "~")
        @marker = marker
    end

    def to_s
        self.marker
    end
end

class Board 

    def initialize
        @data = Array.new(3){ Array.new(3) { Cell.new } }
        @current = @p1
        @opponent = @p2
    end

    def to_s
        rows = @data.map do |row| 
            row.join(" | ")
        end
        rows.join("\n----------\n")
    end

    def valid?(move)
        if move.class == Integer && move.between?(1, 9)
          true
        else
          false
        end
    end
  
    def available?(x, y)
        board[y][x].empty?
    end

    def solicit_move(player)
        "#{@current.name}, please place your mark (1-9)"
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
        if available?(x, y)
            make_move(x, y)
            board.to_s
        else
            return "Sorry #{current.name}, that spot is taken"
            solicit_move
        end
    end



    def make_move(x, y)
        @data[x][y] = @current.marker
    end


    def switch
        @current, @opponent = @opponent, @current
    end

    def draw?
        board.flatten.map do |cell| 
          cell.marker.none_empty?
        end
    end

    def winner?
        win_positions.each do |win_position|
          return false if win_map(win_position).all_empty?
            return true if win_map(win_position).all_same?
                false
            end
          end
        end
    

    def win_positions
        @board + @board.transpose + diagonals
    end

    def diagonals
    [ [cell_location(0,0), cell_location(1,1), cell_location(2,2)],
    [cell_location(0,2), cell_location(1,1), cell_location(2,0)] ]
    end

    def game_over
        if winner? 
          return :winner
        elsif draw?
          return :draw
        else
          false
        end
    end




def play
end







class Array
  
    def all_same?
      self.all? do |space| 
        space == self[0]
      end
    end
  
    def all_empty?
      self.all? do |space| 
        space.to_s.empty?
      end
    end
  
    def any_empty?
      self.any? do |space| 
        space.to_s.empty?
      end
    end
  
    def none_empty?
      !any_empty?
    end
end


intro
puts "Player 1 -- please input your name."
name = gets.chomp
@p1 = Player.new(name, "X")
puts "Welcome, #{@p1.name}, you are now the #{@p1.marker}!"
puts "\n\n"
puts "Player 2 -- please input your name."
name = gets.chomp
@p2 = Player.new(name, "O")
puts "Welcome, #{@p2.name}, you are now the #{@p2.marker}!"
board = Board.new
begin
    puts "\n"
    puts board.to_s
    puts "\n"
    board.solicit_move(@current)
    move = gets.chomp
    unless valid?(move)
        "It seems you've made a mistake."
    next move_translator(move)
    board.make_move(move, current)
    board.switch
end while game_over? 
# puts "GAME OVER" if(game_over?)

end
