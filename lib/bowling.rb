class Game
  def initialize(line)
    @line_with_frames = Scoreboard.new(line).score
  end

  def score
    calculate_score
  end

  private

  def calculate_score
    score = 0

    puts @line_with_frames.size
    @line_with_frames.each_with_index do |frame, index|
      puts score
      if frame.strike?
        score += 10
        if (index + 1) < 10
          score += @line_with_frames[index+1].descriptor_value
        end
        if (index + 2) < 9
          score += @line_with_frames[index+2].descriptor_value
        end
      end

      if frame.spare?
        score += 10
        if (index + 1) < 9
          score += @line_with_frames[index+1].descriptor_value
        end
      end

      if !frame.spare? && !frame.strike?
        score += frame.descriptor_value
      end
    end

    score
  end
end

class Scoreboard
  STRIKE = "X"
  SPARE = "/"
  MISS = "-"

  def initialize(rolls)
    @line_with_frames = []
    @rolls = parse(rolls)
  end

  def score
    @rolls
  end

  private

  def parse(line)
    index = 0
    parse_from(index, line)
    @line_with_frames
  end

  def parse_from(index, line)
    actual = line[index]

    if actual == STRIKE
      parse_strike(actual, index, line)
    end

    if actual.to_i > 0
      if last_element?(index, line)
        parse_last_element(index, line)
        return
      end

      next_element = line[index+1]

      if next_element == SPARE
        parse_spare(next_element, line, index, actual)
      end

      if next_element == MISS || next_element.to_i > 0
        parse_miss(next_element, line, index, actual)
      end
    end
  end

  def last_element?(index, line)
    index == line.size-1
  end

  def parse_spare(element, line, index, actual)
    @line_with_frames << Spare.new("#{actual}#{element}")
    parse_from(index+2, line)
  end

  def parse_miss(element, line, index, actual)
    @line_with_frames << Frame.new("#{actual}#{element}")
    parse_from(index+2, line)
  end

  def parse_strike(actual, index, line)
    @line_with_frames << Strike.new
    parse_from(index+1, line)
  end

  def parse_last_element(index, line)
    @line_with_frames << Frame.new("#{line[index]}")
  end
end

class Frame
  def initialize(descriptor)
    @value = sum_descriptor_value(descriptor)
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

  def descriptor_value
    score
  end

  private

  def sum_descriptor_value(descriptor)
    descriptor_elements = descriptor.split("")

    descriptor_elements.map(&:to_i).reduce(:+)
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
  def initialize(descriptor)
    @spare = true
    @strike = false
    @value = 10
    @descriptor = descriptor
  end

  def descriptor_value
    sum_descriptor_value(@descriptor)
  end
end
