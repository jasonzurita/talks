import Foundation

public struct MileageSummaryViewData {
    let trips: [Trip]

    var totalMiles: Double {
        trips.map(\.miles).reduce(0, +)
    }

    var totalTime: TimeInterval {
        trips.map(\.dateInterval.duration).reduce(0, +)
    }

    var lastTrip: Trip? {
        guard !trips.isEmpty else { return nil }
        return trips[0]
    }

    public init(trips: [Trip]) {
        self.trips = trips
    }
}
