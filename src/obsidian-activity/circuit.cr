class Obsidian::Activity::Circuit
  def initialize(@map : Hash(Activity, Hash(Signal, Activity)),
                 @stop_events : Array(Activity),
                 @name : String = "",
                 start_task : Activity | Nil = nil)
     @start_task = (start_task || @map.keys.first).as(Activity)
  end

  def call
    executable(@start_task)
  end

  def inspect
    %Q{#<Obsidian::Activity::Circuit @name="#{@name}">}
  end

  private def executable(activity : Activity) : Signal
    signal = activity.call

    return signal if @stop_events.includes?(activity)

    next_activity = @map[activity][signal]?

    if next_activity
      executable(next_activity)
    else
      signal
    end
  end
end
