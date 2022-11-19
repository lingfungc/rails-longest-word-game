require 'open-uri'

class GamesController < ApplicationController
  VOWELS = %w(A E I O U Y)

  def new
    # @letters = []
    # 10.times do
    #   letter = ('A'..'Z').to_a.sample
    #   @letters << letter
    # end
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
  end

  def score
    @letters = params[:letters].split
    @answer = (params[:answer] || '').upcase
    @check = check?(@answer, @letters)
    @english_word = english_word?(@answer)
    @params = params
    # raise
  end

  private

  def check?(answer, letters)
    # make answer into a array of characters
    # iterate each character to check the number of these characters in this answer array and the letters (the question array)
    # the number in answer array should be less or equal than the question array
    answer.chars.all? { |letter| answer.count(letter) <= letters.count(letter) }
  end

  def english_word?(answer)
    dictionary = URI.open("https://wagon-dictionary.herokuapp.com/#{answer}")
    json = JSON.parse(dictionary.read)
    json['found']
  end
end
