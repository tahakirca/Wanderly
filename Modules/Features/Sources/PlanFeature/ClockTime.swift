import Foundation

enum ClockTime {
    static func string(fromMinutes minutes: Int) -> String {
        let hour24 = (minutes / 60) % 24
        let minute = minutes % 60
        let period = hour24 < 12 ? "AM" : "PM"
        var hour = hour24 % 12
        if hour == 0 { hour = 12 }
        return String(format: "%d:%02d %@", hour, minute, period)
    }
}
