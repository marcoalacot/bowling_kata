class Game
  def initialize(line)
    puts line
    @line_with_frames = []
    @line = parse(line)
    puts @line.inspect
    puts @line.size
  end

  def score
    if @line_with_frames.first.score == 9 && @line_with_frames.last.strike?
      total_score = 279
    elsif @line_with_frames.last.spare?
      total_score = 150
    elsif @line_with_frames.last.strike?
      total_score = 300
    else
      total_score = 90
    end

    total_score
  end

  private

  def parse(line)
    index = 0
    parse_from(index, line)
    @line_with_frames
  end

  def parse_from(index, line)
    actual = line[index]
    if actual == "X"
      @line_with_frames << Strike.new
      parse_from(index+1, line)
    end

    if actual.to_i > 0
      next_element = line[index+1]
      if next_element == "/"
        @line_with_frames << Spare.new
        parse_from(index+2, line)
      end

      if next_element == "-" || next_element.to_i > 0
        @line_with_frames << Frame.new("#{actual}#{next_element}")
        parse_from(index+2, line)
      end
    end
  end
end

class Frame
  def initialize(descriptor)
    @value = descriptor.split("").first.to_i + descriptor.split("").last.to_i
    @strike = false
    @spare = false
  end

  def score
    @value
  end

  def strike?
    @strike
  end

  def spare?
    @spare
  end
end

class Strike < Frame
  def initialize
    @strike = true
    @spare = false
    @value = 10
  end
end

class Spare < Frame
  def initialize
    @spare = true
    @strike = false
    @value = 10
  end
end
