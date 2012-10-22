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

  #arguably these methods could all be replaced by a state setter, allowing
  #each state to know what its exit states are. I've shied away from that
  #because such a setter would need to be public and I don't want all users
  #of this class to be able to manipulate its state directly.
  def player_one_wins
    @state = P1WinsState.new
  end

  def player_two_wins
    @state = P2WinsState.new
  end

  def deuce
    @state = DeuceState.new(self)
  end

  def advantage_player_one
    @state = P1AdvantageState.new(self)
  end

  def advantage_player_two
    @state = P2AdvantageState.new(self)
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
      @game.deuce if @player_one_points == 3 and @player_two_points == 3
      if @player_one_points > 3
        @game.player_one_wins
      end
    end

    def player_two_scores
      @player_two_points += 1
      @game.deuce if @player_one_points == 3 and @player_two_points == 3
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
      @game.advantage_player_one
    end

    def player_two_scores
      @game.advantage_player_two
    end

    def score
      "Deuce"
    end
  end
end
