

#define constant for all win combinations
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]


#method to display blank board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#method to get input to index - convert user input to an integer
def input_to_index(user_input)
  user_input.to_i - 1
end

#define a move method
def move(board, user_input, player_char)
  board[user_input] = player_char
end

#checks if position in board is taken or not
def position_taken?(board, position)
  !(board[position] == " " || board[position] == "")
end

#check to determine if move is valid or not
#valid would be not taken, within 0-8 (input to index method) and not nil
def valid_move?(board, position)
  position.between?(0,8) && !position_taken?(board, position)
end

#turn makes valid moves
#need to figure out who is X and who is O
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  updated_input = input_to_index(input)
  if valid_move?(board,updated_input)
    player_char = current_player(board)
    move(board, updated_input, player_char)
    display_board(board)
  else
    turn(board)
  end
end

#counts occupied positions
def turn_count(board)
  turn_count = 0
  board.each do |index|
    if index == "X" || index == "O"
    turn_count += 1
    end
  end
  turn_count
end

#current_player method (returns the correct player, if 3rd move that would be X)
#use the turn_count method to see if its X or )
def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end

#won? method returns false for a draw, return true for a win

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

def full?(board)
  board.all?{|token| token == "X" || token == "O"}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || full?(board)
end

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end

#congratulate winning player X or O
def play(board)
  turn_count = turn_count(board) #returns the number of turns
  while turn_count < 9 && over?(board) == false && draw?(board) == false
    turn(board)
    turn_count += 1
  end
  if draw?(board) == true
    puts "Cat's Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end
