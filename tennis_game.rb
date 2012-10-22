class TennisGame
  attr_reader :winner
  def initialize
    @state = NormalState.new(self)
  end

  def winner
    @state.winner
  end

  def player_one_scores
    @state.player_one_scores
  end

  def player_two_scores
    @state.player_two_scores
  end

  def finish(winner)
    @state = WonState.new(winner)
  end

  def deuce
    @state = DeuceState.new(self)
  end

  def advantage(player)
    if player == :player_one
      @state = P1AdvantageState.new(self)
    else
      @state = P2AdvantageState.new(self)
    end
  end

  def forty_thirty
    @state = FortyThirtyState.new(self)
  end

  def thirtyforty
    @state = ThirtyFortyState.new(self)
  end

  class GameState
    def winner
    end
  end

  class NormalState < GameState
    def initialize(game)
      @game = game
      @player_one_points = 0
      @player_two_points = 0
    end

    def player_one_scores
      @player_one_points += 1
      @game.forty_thirty if @player_one_points == 3 && @player_two_points == 2
      if @player_one_points > 3
        @game.finish(:player_one)
      end
    end

    def player_two_scores
      @player_two_points += 1
      @game.thirty_forty if @player_two_points == 3 && @player_one_points == 2
      if @player_two_points > 3
        @game.finish(:player_two)
      end
    end
  end

  class WonState
    attr_reader :winner
    def initialize(winner)
      @winner = winner
    end
  end

  class P1AdvantageState < GameState
    def initialize(game)
      @game = game
    end

    def player_one_scores
      @game.finish(:player_one)
    end

    def player_two_scores
      @game.deuce
    end
  end

  class P2AdvantageState < GameState
    def initialize(game)
      @game = game
    end

    def player_one_scores
      @game.deuce
    end

    def player_two_scores
      @game.finish(:player_two)
    end
  end

  class DeuceState < GameState
    def initialize(game)
      @game = game
    end

    def player_one_scores
      @game.advantage(:player_one)
    end

    def player_two_scores
      @game.advantage(:player_two)
    end
  end

  class FortyThirtyState < GameState
    def initialize(game)
      @game = game
    end

    def player_one_scores
      @game.finish(:player_one)
    end

    def player_two_scores
      @game.deuce
    end
  end

  class ThirtyFortyState < GameState
    def initialize(game)
      @game = game
    end

    def player_one_scores
      @game.deuce
    end

    def player_two_scores
      @game.finish(:player_two)
    end
  end
end
