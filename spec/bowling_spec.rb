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
    frame = Frame.new("X")

    expect(frame.score).to eq(10)

    frame = Frame.new("9-")

    expect(frame.score).to eq(9)

    frame = Frame.new("5/")

    expect(frame.score).to eq(10)
  end

  it "knows if it's a strike" do
    frame = Frame.new("X")

    expect(frame.strike?).to eq(true)

    frame = Frame.new("9/")

    expect(frame.strike?).to eq(false)
  end

  it "knows if it's a spare" do
    frame = Frame.new("4/")

    expect(frame.spare?).to eq(true)

    frame = Frame.new("X")

    expect(frame.spare?).to eq(false)
  end
end
