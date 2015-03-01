require_relative "../lib/bowling"

describe Game do
  it "knows the total score" do
    rolls = "XXXXXXXXXXXX"

    game = Game.new(rolls)
    expect(game.score).to eq(300)
  end

  it "knows the total score" do
    rolls = "9-9-9-9-9-9-9-9-9-9-"

    game = Game.new(rolls)
    expect(game.score).to eq(90)
  end

  it "knows the total score" do
    rolls = "5/5/5/5/5/5/5/5/5/5/5"

    game = Game.new(rolls)
    expect(game.score).to eq(150)
  end

  it "knows the total score" do
    rolls = "9-XXXXXXXXXXX"

    game = Game.new(rolls)
    expect(game.score).to eq(279)
  end
end

describe Frame do
  it "knows it's score" do
    frame = Strike.new

    expect(frame.score).to eq(10)

    frame = Spare.new

    expect(frame.score).to eq(10)

    frame = Frame.new("5/")

    expect(frame.score).to eq(5)

    frame = Frame.new("53")

    expect(frame.score).to eq(8)
  end

  it "knows if it's a strike" do
    frame = Strike.new

    expect(frame.strike?).to eq(true)
    expect(frame.spare?).to eq(false)
  end

  it "knows if it's a spare" do
    frame = Spare.new

    expect(frame.strike?).to eq(false)
    expect(frame.spare?).to eq(true)
  end
end

describe Scoreboard do
  it "parses a line and returns an array with the scores" do
    rolls = "XXX"
    strike = Strike.new
    allow(Strike).to receive(:new).and_return(strike)

    scoreboard = Scoreboard.new(rolls)
    expect(scoreboard.score).to eq([strike, strike, strike])
  end

  it "parses a line and returns an array with the scores" do
    rolls = "X5/XX"
    strike = Strike.new
    spare = Spare.new

    allow(Strike).to receive(:new).and_return(strike)
    allow(Spare).to receive(:new).and_return(spare)

    scoreboard = Scoreboard.new(rolls)
    expect(scoreboard.score).to eq([strike, spare, strike, strike])
  end

  it "parses a line and returns an array with the scores" do
    rolls = "X5/4-5/5"
    strike = Strike.new
    spare = Spare.new
    frame = Frame.new("4-")

    allow(Strike).to receive(:new).and_return(strike)
    allow(Spare).to receive(:new).and_return(spare)
    allow(Frame).to receive(:new).and_return(frame)

    scoreboard = Scoreboard.new(rolls)
    expect(scoreboard.score).to eq([strike, spare, frame, spare, frame])
  end
end
