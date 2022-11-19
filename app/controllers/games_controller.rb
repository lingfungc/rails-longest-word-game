require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      letter = ('A'..'Z').to_a.sample
      @letters << letter
    end
  end

  def score
    @letters = params[:letters].split
    @answer = (params[:answer] || '').upcase
    @check = check?(@answer, @letters)
    # @english_word = english_word?(@word)
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

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
