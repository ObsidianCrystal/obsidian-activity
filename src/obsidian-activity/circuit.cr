class Obsidian::Activity::Circuit
  def initialize(@map : Hash(Activity, Hash(Signal, Activity)),
                 @stop_events : Array(Activity),
                 @name : String = "",
                 start_task : Activity | Nil = nil,
                 @data = Data.new)
     @start_task = (start_task || @map.keys.first).as(Activity)
  end

  def call : Tuple(Signal, Data)
    executable(@start_task, @data)
  end

  def inspect
    %Q{#<Obsidian::Activity::Circuit @name="#{@name}">}
  end

  private def executable(activity : Activity, data : Data) : Tuple(Signal, Data)
    signal = activity.call(data)

    return signal if @stop_events.includes?(activity)

    next_activity = @map[activity][signal[0]]?

    if next_activity
      executable(next_activity, signal[1])
    else
      signal
    end
  end
end
