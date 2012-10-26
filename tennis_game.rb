class TennisGame
  def initialize
    @state = NormalState.new(self)
    @scoreboards = []
  end

  def add_scoreboard(scoreboard)
    @scoreboards << scoreboard
  end

  def update_scoreboards(score)
    @scoreboards.each {|s| s.score_changed(score) }
  end

  def player_one_scores
    @state.player_one_scores
  end

  def player_two_scores
    @state.player_two_scores
  end

  def player_one_wins
    @scoreboards.each(&:player_one_wins)
  end

  def player_two_wins
    @scoreboards.each(&:player_two_wins)
  end

  def deuce
    @state = DeuceState.new(self)
    self.update_scoreboards(Score.new(3, 3))
  end

  def advantage_player_one
    @state = P1AdvantageState.new(self)
    self.update_scoreboards(Score.new(4, 3))
  end

  def advantage_player_two
    @state = P2AdvantageState.new(self)
    self.update_scoreboards(Score.new(3, 4))
  end

  class NormalState
    def initialize(game)
      @game = game
      @player_one_points = 0
      @player_two_points = 0
    end

    def player_one_scores
      @player_one_points += 1
      if @player_one_points == 3 and @player_two_points == 3
        @game.deuce
      elsif @player_one_points > 3
        @game.player_one_wins
      else
        @game.update_scoreboards(Score.new(@player_one_points, @player_two_points))
      end
    end

    def player_two_scores
      @player_two_points += 1
      if @player_one_points == 3 and @player_two_points == 3
        @game.deuce
      elsif @player_two_points > 3
        @game.player_two_wins
      else
        @game.update_scoreboards(Score.new(@player_one_points, @player_two_points))
      end
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
  end
end
