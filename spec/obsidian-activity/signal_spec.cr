require "../spec_helper"

describe Obsidian::Activity::Signal do
  it "failure is a signal" do
    Obsidian::Activity::FAILURE.should be_a(Obsidian::Activity::Signal)
  end

  it "success is a signal" do
    Obsidian::Activity::SUCCESS.should be_a(Obsidian::Activity::Signal)
  end
end
