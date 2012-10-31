class TennisGame
  def initialize
    @state = NormalState.new
    @scoreboards = []
  end

  def add_scoreboard(scoreboard)
    @scoreboards << scoreboard
  end

  def player_one_scores
    update_state(@state.player_one_scores)
  end

  def player_two_scores
    update_state(@state.player_two_scores)
  end

  private

  def update_state(new_state)
    @state = new_state
    @scoreboards.each {|s| @state.score.update_scoreboard(s) }
  end

  class NormalState
    def initialize(p1_points=0, p2_points=0)
      @player_one_points = p1_points
      @player_two_points = p2_points
    end

    def score
      Score.new(@player_one_points, @player_two_points)
    end

    def player_one_scores
      point_scored(@player_one_points + 1, @player_two_points)
    end

    def player_two_scores
      point_scored(@player_one_points, @player_two_points + 1)
    end

    private

    def point_scored(player_one_points, player_two_points)
      if player_one_points == 3 and player_two_points == 3
        DeuceState.new
      elsif player_one_points > 3
        P1WinState.new
      elsif player_two_points > 3
        P2WinState.new
      else
        NormalState.new(player_one_points, player_two_points)
      end
    end
  end

  class P1AdvantageState
    def score
      Score.new(4, 3)
    end

    def player_one_scores
      P1WinState.new
    end

    def player_two_scores
      DeuceState.new
    end
  end

  class P2AdvantageState

    def score
      Score.new(3, 4)
    end

    def player_one_scores
      DeuceState.new
    end

    def player_two_scores
      P2WinState.new
    end
  end

  class P1WinState
    def score
      Player1Win.new
    end
  end

  class P2WinState
    def score
      Player2Win.new
    end
  end

  class DeuceState

    def score
      Score.new(3, 3)
    end

    def player_one_scores
      P1AdvantageState.new
    end

    def player_two_scores
      P2AdvantageState.new
    end
  end
end
