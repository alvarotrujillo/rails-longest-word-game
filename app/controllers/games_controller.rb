require "open-uri"

class GamesController < ApplicationController
  def new
    vowels = (0..1).map { %w[a e i o u].to_a[rand(5)] }.join
    other_letters = (0..7).map { ('a'..'z').to_a[rand(26)] }.join
    @letters = vowels + other_letters
  end

  user_key = params[:userWord]

  def score
    correct_letters = params[:userWord].split('').all? { |letter| params[:letters].include?(letter) }
    url = `https://wagon-dictionary.herokuapp.com/#{user_key}`
    validity = JSON.parse(URI.open(url).read)

    if correct_letters
      @result = 'Correct letters'
    else
      @result = 'wrong letters'
    end
  end
end
