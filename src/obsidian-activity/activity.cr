class Obsidian::Activity
  def initialize(&block : -> Signal)
    @proc = block
  end

  def call
    @proc.call
  end
end
