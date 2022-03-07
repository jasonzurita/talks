import Foundation
import MTWorld

public struct Trip: Identifiable {
    public let id = UUID()
    let miles: Double
    let dateInterval: DateInterval

    public init(miles: Double, dateInterval: DateInterval) {
        self.miles = miles
        self.dateInterval = dateInterval
    }
}

public extension Trip {
    static var mock: Self {
        Self(miles: 10, dateInterval: DateInterval(start: Current.currentDate(), duration: 100))
    }
}
