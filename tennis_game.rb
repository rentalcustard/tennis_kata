class TennisGame
  def initialize
    @state = NormalState.new(self)
  end

  def p1_score
    @state.p1_score
  end

  def p2_score
    @state.p2_score
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

    def p1_score
      TENNIS_SCORES[@player_one_points]
    end

    def p2_score
      TENNIS_SCORES[@player_two_points]
    end
  end

  class P1WinsState
    def p1_score
      "W"
    end

    def p2_score
      "L"
    end
  end

  class P2WinsState
    def p1_score
      "L"
    end

    def p2_score
      "W"
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

    def p1_score
      "A"
    end

    def p2_score
      "40"
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

    def p1_score
      "40"
    end

    def p2_score
      "A"
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

    def p1_score
      "Deuce"
    end

    def p2_score
      "Deuce"
    end
  end
end
