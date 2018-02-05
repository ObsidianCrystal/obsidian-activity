class Obsidian::Activity
  # TODO: Data should be a hash
  class Data
    def initialize
      @inc = 0
    end

    # TODO: Remove this
    def inc
      @inc += 1
    end

    def get
      @inc
    end
  end
end
