{
  ru: {
    date: {
      formats: {
        trestle_date: proc { |date| "#{date.day} %b %Y" },
        trestle_calendar: "%m/%d/%Y"
      }
    },

    time: {
      formats: {
        trestle_date: proc { |time| "#{time.day} %b %Y" },
        trestle_time: "%H:%M",
        trestle_time_with_seconds: "%H:%M:%S"
      }
    }
  }
}
