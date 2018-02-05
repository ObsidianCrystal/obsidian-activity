require "../spec_helper"

describe Obsidian::Activity do
  it "run proc" do
    init_signal = Obsidian::Activity::Signal.new
    activity = Obsidian::Activity.new { |data| { init_signal, data } }

    signal, data = activity.call(Obsidian::Activity::Data.new)

    signal.should eq(init_signal)
    data.get.should eq(0)
  end
end
