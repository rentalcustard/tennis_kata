require_relative 'tennis_game'
describe TennisGame do
  context "initially" do
    its(:winner) { should be_nil }
  end

  context "player 1 wins 40-0" do
    before {
      4.times { subject.player_one_scores }
    }

    its(:winner) { should eq(:player_one) }
  end

  context "player 2 wins 40-0" do
    before {
      4.times { subject.player_two_scores }
    }

    its(:winner) { should eq(:player_two) }
  end

  context "in progress, 15-0" do
    before { subject.player_one_scores }
    its(:winner) { should be_nil }
  end

  context "deuce" do
    before {
      subject.player_one_scores
      subject.player_one_scores
      subject.player_two_scores
      subject.player_two_scores
      subject.player_one_scores
      subject.player_two_scores
    }

    its(:winner) { should be_nil }
  end

  context "advantage p2" do
    before {
      subject.player_one_scores
      subject.player_one_scores
      subject.player_two_scores
      subject.player_two_scores
      subject.player_one_scores
      subject.player_two_scores
      subject.player_two_scores
    }

    its(:winner) { should be_nil }

    context "p2 scores" do
      before {
        subject.player_two_scores
      }

      its(:winner) { should eq(:player_two) }
    end

    context "p1 scores" do
      before {
        subject.player_one_scores
      }

      its(:winner) { should be_nil }

      context "and p1 scores twice more" do
        before {
          subject.player_one_scores
          subject.player_one_scores
        }

        its(:winner) { should eq(:player_one) }
      end
    end
  end
end
