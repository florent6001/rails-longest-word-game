require 'open-uri'

class GamesController < ApplicationController
  def new
    letters = ('A'..'Z').to_a
    @letters = []
    10.times do
      random = rand(0..letters.size)
      @letters.push(letters[random])
    end
  end

  def score
    @letters = params[:letters].split(' ')
    @word = params[:word]
    current_score = session[:score] ? session[:score].to_i : 0

    if letter_inside_grid?(@word, @letters)
      parsed_data = JSON.parse(URI.open("https://wagon-dictionary.herokuapp.com/#{@word}").read)
      @valid = parsed_data["found"]
      @inarray = true
      session[:score] = current_score + @word.length
    else
      @inarray = false
    end
  end

  private

  def letter_inside_grid?(attempt, grid)
    valid = true
    attempt.upcase.chars.each do |letter|
      valid = false unless grid.include?(letter)
      grid.delete_at(grid.index(letter)) if grid.include?(letter)
    end
    valid
  end
end
