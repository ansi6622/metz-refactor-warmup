require 'spec_helper'

describe 'User can play Ten Thousand' do

  it 'initializes a new game with players' do
    players = {"player_1" => "Albert", "player_2" => "Eddie"}
    game = Game.new(players)
    expect(game.players.length).to eq(2)
    expect(game.available_dice).to eq(6)
    expect(game.current_player.player_name).to eq("Albert")
    expect(game.players.first.total_score).to eq 0
    expect(game.players.last.total_score).to eq 0
    expect(game.players.first.current_score).to eq 0
    expect(game.players.last.current_score).to eq 0
    expect(game.last_roll).to eq []

  end

  it 'properly orders players if a new game is saved' do
    players = {"player_1" => "Albert", "player_2" => "Eddie"}
    game = Game.new(players)
    game.save!

    # you need to mess with the players association to mess up the order
    expect(game.players.length).to eq(2)
    expect(game.current_player.player_name).to eq("Albert")
  end

  it 'allows a user to roll, tracks last roll' do
    srand(1)
    players = {"player_1" => "Albert", "player_2" => "Eddie"}
    game = Game.new(players)
    game.roll_again([])
    actual = game.last_roll
    expected = [[1, "⚀"], [2, "⚁"], [4, "⚃"], [4, "⚃"], [5, "⚄"], [6, "⚅"]]
    expect(actual).to eq(expected)
    srand(Random.new_seed)
  end

  it 'allows a user to roll and then score 1s and 5s' do
    srand(1)
    players = {"player_1" => "Albert", "player_2" => "Eddie"}
    game = Game.new(players)
    game.roll_again([])
    game.stay(['1', '5'])
    actual = game.players.order(:id)[0].total_score
    expected = 150
    expect(actual).to eq(expected)
    srand(Random.new_seed)
  end

  it 'allows a user to roll multiple times and then score 1s and 5s' do
    srand(1)
    players = {"player_1" => "Albert", "player_2" => "Eddie"}
    game = Game.new(players)
    game.roll_again([])
    game.roll_again(['1', '1', '5'])
    game.stay(['5', '5'])
    actual = game.players.order(:id)[0].total_score
    expected = 350
    expect(actual).to eq(expected)
    srand(Random.new_seed)
  end

  it 'allows a user to score for three of a kind' do
    srand(19)
    players = {"player_1" => "Albert", "player_2" => "Eddie"}
    game = Game.new(players)
    game.roll_again([])
    game.stay(['3', '3', '3'])
    actual = game.players.order(:id)[0].total_score
    expected = 300
    expect(actual).to eq(expected)
    srand(Random.new_seed)
  end

  it 'allows a user to score for four of a kind' do
    srand(31)
    players = {"player_1" => "Albert", "player_2" => "Eddie"}
    game = Game.new(players)
    game.roll_again([])
    game.stay(['3', '3', '3', '3'])
    actual = game.players.order(:id)[0].total_score
    expected = 600
    expect(actual).to eq(expected)
    srand(Random.new_seed)
  end

  it 'allows a user to score for five of a kind' do
    srand(4239)
    players = {"player_1" => "Albert", "player_2" => "Eddie"}
    game = Game.new(players)
    game.roll_again([])
    game.stay(['3', '3', '3', '3', '3'])
    actual = game.players.order(:id)[0].total_score
    expected = 1200
    expect(actual).to eq(expected)
    srand(Random.new_seed)
  end

  it 'allows a user to score for six of a kind' do
    srand(11604)
    players = {"player_1" => "Albert", "player_2" => "Eddie"}
    game = Game.new(players)
    game.roll_again([])
    game.stay(['3', '3', '3', '3', '3', '3'])
    actual = game.players.order(:id)[0].total_score
    expected = 2400
    expect(actual).to eq(expected)
    srand(Random.new_seed)
  end

  it 'allows a user to score for a straight' do
    srand(26)
    players = {"player_1" => "Albert", "player_2" => "Eddie"}
    game = Game.new(players)
    game.roll_again([])
    game.stay(['1', '2', '3', '4', '5', '6'])
    actual = game.players.order(:id)[0].total_score
    expected = 1500
    expect(actual).to eq(expected)
    srand(Random.new_seed)
  end

  it 'allows a user to score for three pair' do
    srand(189)
    players = {"player_1" => "Albert", "player_2" => "Eddie"}
    game = Game.new(players)
    game.roll_again([])
    game.stay(['2', '2', '3', '3', '4', '4'])
    actual = game.players.order(:id)[0].total_score
    expected = 750
    expect(actual).to eq(expected)
    srand(Random.new_seed)
  end

  it 'allows a user to score for three pair but not add the extra 1s or 5s' do
    srand(1001)
    players = {"player_1" => "Albert", "player_2" => "Eddie"}
    game = Game.new(players)
    game.roll_again([])
    game.stay(['1', '1', '5', '5', '6', '6'])
    actual = game.players.order(:id)[0].total_score
    expected = 750
    expect(actual).to eq(expected)
    srand(Random.new_seed)
  end

  it 'allows a user to score for two three-of-a-kind' do
    srand(281)
    players = {"player_1" => "Albert", "player_2" => "Eddie"}
    game = Game.new(players)
    game.roll_again([])
    game.stay(['1', '1', '1', '5', '5', '5'])
    actual = game.players.order(:id)[0].total_score
    expected = 1500
    expect(actual).to eq(expected)
    srand(Random.new_seed)
  end

  it 'allows a user to score for five 1s' do
    pending
    srand(7099)
    players = {"player_1" => "Albert", "player_2" => "Eddie"}
    game = Game.new(players)
    game.roll_again([])
    game.stay(['1', '1', '1', '1', '1'])
    actual = game.players.order(:id)[0].total_score
    expected = 4000
    expect(actual).to eq(expected)
    srand(Random.new_seed)
  end

  it 'allows a user to score for six 1s' do
    pending
    srand(1472)
    players = {"player_1" => "Albert", "player_2" => "Eddie"}
    game = Game.new(players)
    game.roll_again([])
    game.stay(['1', '1', '1', '1', '1', '1'])
    actual = game.players.order(:id)[0].total_score
    expected = 8000
    expect(actual).to eq(expected)
    srand(Random.new_seed)
  end

end
