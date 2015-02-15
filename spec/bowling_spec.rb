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
