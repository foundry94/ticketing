class Event < ActiveRecord::Base
  include IceCube
  serialize :schedule, Hash

  belongs_to :venue
  attr_accessible :name, :price, :venue_id
  validates_presence_of :name, :price, :venue_id

  def schedule=(new_schedule)
    write_attribute(:schedule, new_schedule.to_hash)
  end

  def schedule
    Schedule.from_hash(read_attribute(:schedule))
  end

  def set_schedule(event_schedule)
    date = event_schedule['start_date']
    components = date.split('/')
    date = components[1] + "/" + components[0] + "/" + components[2]

    start_time = event_schedule['start_time']
    end_time = event_schedule['end_time']

    start_datetime = date + " " + start_time
    start_datetime = Time.parse(start_datetime)

    end_datetime = date + " " + end_time
    end_datetime = Time.parse(end_datetime)
    
    schedule = IceCube::Schedule.new(start_datetime, :end_time => end_datetime)

    set_recurring_rules(schedule, event_schedule['repeats'])

    self.schedule = schedule
  end

  def set_recurring_rules(schedule, repeat_rules)

    if repeat_rules['is_checked'] && repeat_rules['type'] == 'Weekly'
      repeat_rules['days'].each do |day|
        schedule.add_recurrence_rule IceCube::Rule.weekly.day(day.to_i)
      end
    end

  end

end
