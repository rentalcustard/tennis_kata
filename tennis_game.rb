class TennisGame
  def initialize
    @state = NormalState.new
    @scoreboards = []
  end

  def add_scoreboard(scoreboard)
    @scoreboards << scoreboard
  end

  def update_scoreboards(score)
    @scoreboards.each {|s| s.score_changed(score) }
  end

  def player_one_scores
    @state = @state.player_one_scores
    @state.enter(self)
  end

  def player_two_scores
    @state = @state.player_two_scores
    @state.enter(self)
  end

  def player_one_wins
    @scoreboards.each(&:player_one_wins)
  end

  def player_two_wins
    @scoreboards.each(&:player_two_wins)
  end

  class NormalState
    def initialize(p1_points=0, p2_points=0)
      @player_one_points = p1_points
      @player_two_points = p2_points
    end

    def enter(game)
      game.update_scoreboards(Score.new(@player_one_points, @player_two_points))
    end

    def player_one_scores
      new_p1_score = @player_one_points + 1
      if new_p1_score == 3 and @player_two_points == 3
        DeuceState.new
      elsif new_p1_score > 3
        P1WinState.new
      else
        NormalState.new(new_p1_score, @player_two_points)
      end
    end

    def player_two_scores
      new_p2_score = @player_two_points + 1
      if @player_one_points == 3 and new_p2_score == 3
        DeuceState.new
      elsif new_p2_score > 3
        P2WinState.new
      else
        NormalState.new(@player_one_points, new_p2_score)
      end
    end
  end

  class P1AdvantageState

    def enter(game)
      game.update_scoreboards(Score.new(4, 3))
    end

    def player_one_scores
      P1WinState.new
    end

    def player_two_scores
      DeuceState.new
    end
  end

  class P2AdvantageState

    def enter(game)
      game.update_scoreboards(Score.new(3, 4))
    end

    def player_one_scores
      DeuceState.new
    end

    def player_two_scores
      P2WinState.new
    end
  end

  class P1WinState
    def enter(game)
      game.player_one_wins
    end
  end

  class P2WinState
    def enter(game)
      game.player_two_wins
    end
  end

  class DeuceState

    def enter(game)
      game.update_scoreboards(Score.new(3, 3))
    end

    def player_one_scores
      P1AdvantageState.new
    end

    def player_two_scores
      P2AdvantageState.new
    end
  end
end
