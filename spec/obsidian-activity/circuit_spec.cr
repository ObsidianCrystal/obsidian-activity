require "../spec_helper"

describe Obsidian::Activity::Circuit do
  it "run proc" do
    start  = Obsidian::Activity.new { print "Hello";  Obsidian::Activity::SUCCESS }
    left   = Obsidian::Activity.new { print " World"; Obsidian::Activity::SUCCESS }
    right1 = Obsidian::Activity.new { print " My";    Obsidian::Activity::SUCCESS }
    right2 = Obsidian::Activity.new { print " Right"; Obsidian::Activity::SUCCESS }

    map = {
      start => { Obsidian::Activity::SUCCESS => right1 },
      right1 => { Obsidian::Activity::FAILURE => left, Obsidian::Activity::SUCCESS => right2},
    }

    circuit = Obsidian::Activity::Circuit.new(map, [left, right2], start_task: start)

    circuit.call.should eq(Obsidian::Activity::SUCCESS)
  end
end
