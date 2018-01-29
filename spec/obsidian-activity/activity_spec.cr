require "../spec_helper"

describe Obsidian::Activity do
  it "run proc" do
    signal = Obsidian::Activity::Signal.new
    activity = Obsidian::Activity.new { signal }

    activity.call.should eq(signal)
  end
end
