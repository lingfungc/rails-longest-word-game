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
    # @letters = params[:letters].split
    # @word = (params[:word] || "").upcase
    # @included = included?(@word, @letters)
    # @english_word = english_word?(@word)
    @params = params
    # raise
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
