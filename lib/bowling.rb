class Game
  def initialize(score)
    @score = score
  end

  def score
    splitted_score = @score.split("")
    if splitted_score.first == "9" && splitted_score.last == "X"
      total_score = 279
    elsif splitted_score.last == "5"
      total_score = 150
    elsif splitted_score.last == "X"
      total_score = 300
    else
      total_score = 90
    end

    total_score
  end
end
