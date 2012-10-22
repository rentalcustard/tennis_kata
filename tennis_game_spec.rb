require_relative 'tennis_game'
describe TennisGame do
  context "initially" do
    its(:score) { should eq("0 - 0")}
  end

  context "player 1 wins to love" do
    before {
      4.times { subject.player_one_scores }
    }

    its(:score) { should eq("Player One wins")}
  end

  context "player 2 wins to love" do
    before {
      4.times { subject.player_two_scores }
    }

    its(:score) { should eq("Player Two wins")}
  end

  context "15-0" do
    before { subject.player_one_scores }

    its(:score) { should eq("15 - 0") }
  end

  context "30-0" do
    before {
      subject.player_one_scores
      subject.player_one_scores
    }

    its(:score) { should eq("30 - 0") }
  end

  context "40-0" do
    before {
      subject.player_one_scores
      subject.player_one_scores
      subject.player_one_scores
    }

    its(:score) { should eq("40 - 0") }
  end

  context "40-15" do
    before {
      subject.player_one_scores
      subject.player_one_scores
      subject.player_one_scores
      subject.player_two_scores
    }

    its(:score) { should eq("40 - 15") }
  end

  context "40-30" do
    before {
      subject.player_one_scores
      subject.player_one_scores
      subject.player_one_scores
      subject.player_two_scores
      subject.player_two_scores
    }

    its(:score) { should eq("40 - 30") }
  end

  context "0-15" do
    before {
      subject.player_two_scores
    }

    its(:score) { should eq("0 - 15")}
  end

  context "0-30" do
    before {
      subject.player_two_scores
      subject.player_two_scores
    }

    its(:score) { should eq("0 - 30")}
  end

  context "0-40" do
    before {
      subject.player_two_scores
      subject.player_two_scores
      subject.player_two_scores
    }

    its(:score) { should eq("0 - 40")}
  end

  context "15-40" do
    before {
      subject.player_two_scores
      subject.player_two_scores
      subject.player_two_scores
      subject.player_one_scores
    }

    its(:score) { should eq("15 - 40")}
  end

  context "30-40" do
    before {
      subject.player_two_scores
      subject.player_two_scores
      subject.player_two_scores
      subject.player_one_scores
      subject.player_one_scores
    }

    its(:score) { should eq("30 - 40")}
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

    its(:score) { should eq("Deuce") }
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

    its(:score) { should eq("40 - A")}

    context "p2 scores" do
      before {
        subject.player_two_scores
      }

      its(:score) { should eq("Player Two wins") }
    end

    context "p1 scores" do
      before {
        subject.player_one_scores
      }

      its(:score) { should eq("Deuce") }

      context "and p1 scores twice more" do
        before {
          subject.player_one_scores
          subject.player_one_scores
        }

        its(:score) { should eq("Player One wins") }
      end
    end
  end
end
