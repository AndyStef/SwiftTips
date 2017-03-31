
//Handy way to format day in format "Some time ago"
extension Date {
    func timeAgoDisplay() -> String {
        let secondsAgo =  Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = minute * 60
        let day = hour * 24
        let week = day * 7
        let month = week * 4
        let year = month * 12
        
        func getResultWith(timeUnit: Int, andTimeUnitName timeUnitName: String) -> String {
            let resultTime = secondsAgo / timeUnit
            return resultTime == 1 ? "1 \(timeUnitName) ago" : "\(resultTime) \(timeUnitName)s ago"
        }
        
        if secondsAgo < minute {
            return "\(secondsAgo) seconds ago"
        } else if secondsAgo < hour {
            return getResultWith(timeUnit: minute, andTimeUnitName: "minute")
        } else if secondsAgo < day {
            return getResultWith(timeUnit: hour, andTimeUnitName: "hour")
        } else if secondsAgo < week {
            return getResultWith(timeUnit: day, andTimeUnitName: "day")
        } else if secondsAgo < month {
            return getResultWith(timeUnit: week, andTimeUnitName: "week")
        } else if secondsAgo < year {
            return getResultWith(timeUnit: month, andTimeUnitName: "month")
        }
        
        return getResultWith(timeUnit: year, andTimeUnitName: "year")
    }
}
