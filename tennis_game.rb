class TennisGame
  def initialize
    @state = NormalState.new(self)
  end

  def score
    @state.score
  end

  def player_one_scores
    @state.player_one_scores
  end

  def player_two_scores
    @state.player_two_scores
  end

  def player_one_wins
    @state = P1WinsState.new
  end

  def player_two_wins
    @state = P2WinsState.new
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

  def thirty_forty
    @state = ThirtyFortyState.new(self)
  end

  class NormalState
    TENNIS_SCORES = {
      0 => "0",
      1 => "15",
      2 => "30",
      3 => "40"
    }
    def initialize(game)
      @game = game
      @player_one_points = 0
      @player_two_points = 0
    end

    def player_one_scores
      @player_one_points += 1
      @game.forty_thirty if @player_one_points == 3 && @player_two_points == 2
      @game.thirty_forty if @player_one_points == 2 && @player_two_points == 3
      if @player_one_points > 3
        @game.player_one_wins
      end
    end

    def player_two_scores
      @player_two_points += 1
      @game.thirty_forty if @player_two_points == 3 && @player_one_points == 2
      @game.forty_thirty if @player_one_points == 3 && @player_two_points == 2
      if @player_two_points > 3
        @game.player_two_wins
      end
    end

    def score
      "#{TENNIS_SCORES[@player_one_points]} - #{TENNIS_SCORES[@player_two_points]}"
    end
  end

  class P1WinsState
    def score
      "Player One wins"
    end
  end

  class P2WinsState
    def score
      "Player Two wins"
    end
  end

  class P1AdvantageState
    def initialize(game)
      @game = game
    end

    def player_one_scores
      @game.player_one_wins
    end

    def player_two_scores
      @game.deuce
    end
  end

  class P2AdvantageState
    def initialize(game)
      @game = game
    end

    def player_one_scores
      @game.deuce
    end

    def player_two_scores
      @game.player_two_wins
    end

    def score
      "40 - A"
    end
  end

  class DeuceState
    def initialize(game)
      @game = game
    end

    def player_one_scores
      @game.advantage(:player_one)
    end

    def player_two_scores
      @game.advantage(:player_two)
    end

    def score
      "Deuce"
    end
  end

  class FortyThirtyState
    def initialize(game)
      @game = game
    end

    def player_one_scores
      @game.player_one_wins
    end

    def player_two_scores
      @game.deuce
    end

    def score
      "40 - 30"
    end
  end

  class ThirtyFortyState
    def initialize(game)
      @game = game
    end

    def player_one_scores
      @game.deuce
    end

    def player_two_scores
      @game.player_two_wins
    end

    def score
      "30 - 40"
    end
  end
end
