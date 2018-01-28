class Obsidian::Activity::Circuit
  def initialize(@map : Hash(Activity, Hash(Signal, Activity)),
                 @stop_events : Array(Activity),
                 @name : String = "",
                 start_task : Activity | Nil = nil)
     start_task = start_task || @map.keys.first
     @start_task = start_task.as(Activity)
  end

  def call
    executable(@start_task)
  end

  private def executable(activity : Activity)
    signal = activity.call

    return activity if @stop_events.includes?(activity)
    
    next_activity = @map[activity][signal]

    if next_activity
      executable(next_activity)
    else
      activity
    end
  end
end
