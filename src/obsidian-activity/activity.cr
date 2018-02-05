class Obsidian::Activity
  def initialize(&block : Data -> Tuple(Signal, Data))
    @proc = block
  end

  def call(data : Data)
    @proc.call(data)
  end
end
