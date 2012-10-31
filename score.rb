class Score < Struct.new(:p1, :p2)
  def update_scoreboard(scoreboard)
    scoreboard.score_changed(self)
  end
end
class Player1Win
  def update_scoreboard(scoreboard)
    scoreboard.player_one_wins
  end
end
class Player2Win
  def update_scoreboard(scoreboard)
    scoreboard.player_two_wins
  end
end
