import CoreLocation
import Foundation
import MTLanguage
import MTLocationClient

// Inspired by: https://vimeo.com/291588126
public var Current: World = .live

public struct World {
    public var currentDate: () -> Date
    public var language: Language
    public var locationClient: LocationClient

    init(
        currentDate: @escaping () -> Date,
        language: Language,
        locationClient: LocationClient
    ) {
        self.currentDate = currentDate
        self.language = language
        self.locationClient = locationClient
    }
}

public extension World {
    static var live: Self {
        Self(
            currentDate: Date.init,
            language: Language(languageStrings: Bundle.main.preferredLocalizations) ?? .en,
            locationClient: .live(accuracy: kCLLocationAccuracyBest)
        )
    }
}

public extension World {
    static var mock: Self {
        Self(
            currentDate: { Date(timeIntervalSince1970: 123_456_789) },
            language: .en,
            locationClient: .authorizedWhenInUse
        )
    }
}
