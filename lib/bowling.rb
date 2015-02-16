class Game
  def initialize(line)
    @line = to_frame(line)
  end

  def score
    puts @line.first.score
    if @line.first.score == 9 && @line.last.strike?
      total_score = 279
    elsif @line.last.score == 5
      total_score = 150
    elsif @line.last.strike?
      total_score = 300
    else
      total_score = 90
    end

    total_score
  end

  private

  def to_frame(line)
    line = line.split("")

    line_with_frames = []

    line.each_with_index do |element, index|
      if element == "X"
        line_with_frames << Frame.new(element)
      elsif element == "/" || element == "-" && (index < line.size - 1)
        frame = line[index-1] + element
        line_with_frames << Frame.new(frame)
      else
        line_with_frames << Frame.new(element)
      end
    end

    line_with_frames
  end
end

class Frame
  attr_reader :frame

  def initialize(frame)
    @frame = frame.split("")
  end

  def score
    points = 0

    if strike? || spare?
      points = 10
    else
      points = @frame.first.to_i
    end

    points
  end

  def strike?
    @frame.first == "X"
  end

  def spare?
    @frame.last == "/"
  end
end
