require "../spec_helper"

describe Obsidian::Activity::Circuit do
  it "run proc" do
    start  = Obsidian::Activity.new { |data| data.inc; { Obsidian::Activity::SUCCESS, data } }
    left   = Obsidian::Activity.new { |data| data.inc; { Obsidian::Activity::SUCCESS, data } }
    right1 = Obsidian::Activity.new { |data| data.inc; { Obsidian::Activity::SUCCESS, data } }
    right2 = Obsidian::Activity.new { |data| { Obsidian::Activity::SUCCESS, data } }

    map = {
      start => { Obsidian::Activity::SUCCESS => right1 },
      right1 => { Obsidian::Activity::FAILURE => left, Obsidian::Activity::SUCCESS => right2},
    }

    circuit = Obsidian::Activity::Circuit.new(map, [left, right2], start_task: start)

    signal, data = circuit.call

    signal.should eq(Obsidian::Activity::SUCCESS)
    data.get.should eq(2)
  end
end
