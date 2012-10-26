require_relative 'tennis_game'
require_relative 'score'

describe TennisGame do
  let(:scoreboard) { mock }
  before {
    subject.add_scoreboard(scoreboard)
  }

  context "player 1 wins to love" do
    it "sends updates to the scoreboard" do
      scoreboard.should_receive(:score_changed).with(Score.new(1, 0))
      scoreboard.should_receive(:score_changed).with(Score.new(2, 0))
      scoreboard.should_receive(:score_changed).with(Score.new(3, 0))
      scoreboard.should_receive(:player_one_wins)

      4.times { subject.player_one_scores }
    end
  end

  context "player 2 wins to love" do
    it "sends updates to the scoreboard" do
      scoreboard.should_receive(:score_changed).with(Score.new(0, 1))
      scoreboard.should_receive(:score_changed).with(Score.new(0, 2))
      scoreboard.should_receive(:score_changed).with(Score.new(0, 3))
      scoreboard.should_receive(:player_two_wins)

      4.times { subject.player_two_scores }
    end
  end

  context "40-15" do
    it "sends updates to the scoreboard" do
      scoreboard.should_receive(:score_changed).with(Score.new(1, 0))
      scoreboard.should_receive(:score_changed).with(Score.new(2, 0))
      scoreboard.should_receive(:score_changed).with(Score.new(3, 0))
      scoreboard.should_receive(:score_changed).with(Score.new(3, 1))

      subject.player_one_scores
      subject.player_one_scores
      subject.player_one_scores
      subject.player_two_scores
    end
  end

  context "40-30" do
    it "sends updates to the scoreboard" do
      scoreboard.should_receive(:score_changed).with(Score.new(1, 0))
      scoreboard.should_receive(:score_changed).with(Score.new(2, 0))
      scoreboard.should_receive(:score_changed).with(Score.new(3, 0))
      scoreboard.should_receive(:score_changed).with(Score.new(3, 1))
      scoreboard.should_receive(:score_changed).with(Score.new(3, 2))

      subject.player_one_scores
      subject.player_one_scores
      subject.player_one_scores
      subject.player_two_scores
      subject.player_two_scores
    end
  end

  context "15-40" do
    it "sends updates to the scoreboard" do
      scoreboard.should_receive(:score_changed).with(Score.new(0, 1))
      scoreboard.should_receive(:score_changed).with(Score.new(0, 2))
      scoreboard.should_receive(:score_changed).with(Score.new(0, 3))
      scoreboard.should_receive(:score_changed).with(Score.new(1, 3))

      subject.player_two_scores
      subject.player_two_scores
      subject.player_two_scores
      subject.player_one_scores
    end
  end

  context "30-40" do
    it "sends updates to the scoreboard" do
      scoreboard.should_receive(:score_changed).with(Score.new(0, 1))
      scoreboard.should_receive(:score_changed).with(Score.new(0, 2))
      scoreboard.should_receive(:score_changed).with(Score.new(0, 3))
      scoreboard.should_receive(:score_changed).with(Score.new(1, 3))
      scoreboard.should_receive(:score_changed).with(Score.new(2, 3))

      subject.player_two_scores
      subject.player_two_scores
      subject.player_two_scores
      subject.player_one_scores
      subject.player_one_scores
    end
  end

  context "deuce" do
    it "sends updates to the scoreboard" do
      scoreboard.should_receive(:score_changed).with(Score.new(1, 0))
      scoreboard.should_receive(:score_changed).with(Score.new(2, 0))
      scoreboard.should_receive(:score_changed).with(Score.new(2, 1))
      scoreboard.should_receive(:score_changed).with(Score.new(2, 2))
      scoreboard.should_receive(:score_changed).with(Score.new(3, 2))
      scoreboard.should_receive(:score_changed).with(Score.new(3, 3))

      subject.player_one_scores
      subject.player_one_scores
      subject.player_two_scores
      subject.player_two_scores
      subject.player_one_scores
      subject.player_two_scores
    end
  end

  context "deuce from 40-0 down" do
    it "sends updates to the scoreboard" do
      scoreboard.should_receive(:score_changed).with(Score.new(1, 0))
      scoreboard.should_receive(:score_changed).with(Score.new(2, 0))
      scoreboard.should_receive(:score_changed).with(Score.new(3, 0))
      scoreboard.should_receive(:score_changed).with(Score.new(3, 1))
      scoreboard.should_receive(:score_changed).with(Score.new(3, 2))
      scoreboard.should_receive(:score_changed).with(Score.new(3, 3))

      subject.player_one_scores
      subject.player_one_scores
      subject.player_one_scores
      subject.player_two_scores
      subject.player_two_scores
      subject.player_two_scores
    end
  end

  context "advantage p2" do
    it "sends updates to the scoreboard" do
      scoreboard.should_receive(:score_changed).with(Score.new(1, 0))
      scoreboard.should_receive(:score_changed).with(Score.new(2, 0))
      scoreboard.should_receive(:score_changed).with(Score.new(2, 1))
      scoreboard.should_receive(:score_changed).with(Score.new(2, 2))
      scoreboard.should_receive(:score_changed).with(Score.new(3, 2))
      scoreboard.should_receive(:score_changed).with(Score.new(3, 3))
      scoreboard.should_receive(:score_changed).with(Score.new(3, 4))

      subject.player_one_scores
      subject.player_one_scores
      subject.player_two_scores
      subject.player_two_scores
      subject.player_one_scores
      subject.player_two_scores
      subject.player_two_scores
    end
  end

  context "p2 wins from advantage" do
    it "sends updates to the scoreboard" do
      scoreboard.should_receive(:score_changed).with(Score.new(1, 0))
      scoreboard.should_receive(:score_changed).with(Score.new(2, 0))
      scoreboard.should_receive(:score_changed).with(Score.new(2, 1))
      scoreboard.should_receive(:score_changed).with(Score.new(2, 2))
      scoreboard.should_receive(:score_changed).with(Score.new(3, 2))
      scoreboard.should_receive(:score_changed).with(Score.new(3, 3))
      scoreboard.should_receive(:score_changed).with(Score.new(3, 4))
      scoreboard.should_receive(:player_two_wins)

      subject.player_one_scores
      subject.player_one_scores
      subject.player_two_scores
      subject.player_two_scores
      subject.player_one_scores
      subject.player_two_scores
      subject.player_two_scores
      subject.player_two_scores
    end
  end

  context "p1 scores from p2's advantage" do
    it "sends updates to the scoreboard" do
      scoreboard.should_receive(:score_changed).with(Score.new(1, 0))
      scoreboard.should_receive(:score_changed).with(Score.new(2, 0))
      scoreboard.should_receive(:score_changed).with(Score.new(2, 1))
      scoreboard.should_receive(:score_changed).with(Score.new(2, 2))
      scoreboard.should_receive(:score_changed).with(Score.new(3, 2))
      scoreboard.should_receive(:score_changed).with(Score.new(3, 3))
      scoreboard.should_receive(:score_changed).with(Score.new(3, 4))
      scoreboard.should_receive(:score_changed).with(Score.new(3, 3))

      subject.player_one_scores
      subject.player_one_scores
      subject.player_two_scores
      subject.player_two_scores
      subject.player_one_scores
      subject.player_two_scores
      subject.player_two_scores
      subject.player_one_scores
    end
  end

  context "p1 scores from advantage" do
    it "sends update to the scoreboard" do
      scoreboard.should_receive(:score_changed).with(Score.new(1, 0))
      scoreboard.should_receive(:score_changed).with(Score.new(2, 0))
      scoreboard.should_receive(:score_changed).with(Score.new(2, 1))
      scoreboard.should_receive(:score_changed).with(Score.new(2, 2))
      scoreboard.should_receive(:score_changed).with(Score.new(3, 2))
      scoreboard.should_receive(:score_changed).with(Score.new(3, 3))
      scoreboard.should_receive(:score_changed).with(Score.new(3, 4))
      scoreboard.should_receive(:score_changed).with(Score.new(3, 3))
      scoreboard.should_receive(:score_changed).with(Score.new(4, 3))
      scoreboard.should_receive(:player_one_wins)

      subject.player_one_scores
      subject.player_one_scores
      subject.player_two_scores
      subject.player_two_scores
      subject.player_one_scores
      subject.player_two_scores
      subject.player_two_scores
      subject.player_one_scores
      subject.player_one_scores
      subject.player_one_scores
    end
  end
end
