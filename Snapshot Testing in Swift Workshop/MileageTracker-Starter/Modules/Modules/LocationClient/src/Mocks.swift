import Combine
import CoreLocation

public extension LocationClient {
    static var authorizedWhenInUse: Self {
        let subject = PassthroughSubject<DelegateEvent, Never>()

        return Self(
            authorizationStatus: { .authorizedWhenInUse },
            requestAlwaysAuthorization: {},
            requestLocation: {
                subject.send(.didUpdateLocations([CLLocation()]))
            },
            mostRecentLocation: { nil },
            startUpdatingLocation: {},
            delegate: subject.eraseToAnyPublisher()
        )
    }

    static var notDetermined: Self {
        var status = CLAuthorizationStatus.notDetermined
        let subject = PassthroughSubject<DelegateEvent, Never>()

        return Self(
            authorizationStatus: { status },
            requestAlwaysAuthorization: {
                status = .authorizedWhenInUse
                subject.send(.didChangeAuthorization(status))
            },
            requestLocation: {
                subject.send(.didUpdateLocations([CLLocation()]))
            },
            mostRecentLocation: { nil },
            startUpdatingLocation: {},
            delegate: subject.eraseToAnyPublisher()
        )
    }

    // A location mock that will send new locations within a given speed range at a specified interval
    static func speedChanging(from fromValue: Double, to toValue: Double, every timeInterval: TimeInterval) -> Self {
        let newLocation: () -> CLLocation = {
            CLLocation(
                coordinate: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
                altitude: 0.0,
                horizontalAccuracy: 0.0,
                verticalAccuracy: 0.0,
                course: 0.0,
                speed: Double.random(in: fromValue ... toValue),
                timestamp: Date()
            )
        }
        let subject = PassthroughSubject<DelegateEvent, Never>()

        let timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { _ in
            subject.send(.didUpdateLocations([newLocation()]))
        }

        return Self(
            authorizationStatus: { .authorizedWhenInUse },
            requestAlwaysAuthorization: {},
            requestLocation: {
                subject.send(.didUpdateLocations([CLLocation()]))
            },
            mostRecentLocation: { nil },
            startUpdatingLocation: {},
            delegate: subject
                .handleEvents(
                    receiveCancel: {
                        timer.invalidate()
                    }
                )
                .share()
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        )
    }

    // swiftlint:disable function_body_length
    static func reaching(
        distanceInMeters: CLLocationDistance,
        speedInMeters: Double,
        withDelay delay: DispatchTime
    ) -> Self {
        let subject = PassthroughSubject<DelegateEvent, Never>()

        // Took from https://stackoverflow.com/a/26500318
        // This seems the most precise one
        func locationWithBearing(
            bearingRadians: Double,
            distanceMeters: Double,
            origin: CLLocationCoordinate2D
        ) -> CLLocationCoordinate2D {
            let distRadians = distanceMeters / 6_372_797.6 // earth radius in meters

            let lat1 = origin.latitude * Double.pi / 180
            let lon1 = origin.longitude * Double.pi / 180

            let lat2 = asin(sin(lat1) * cos(distRadians) + cos(lat1) * sin(distRadians) * cos(bearingRadians))
            let lon2 = lon1 + atan2(sin(bearingRadians) * sin(distRadians) * cos(lat1), cos(distRadians) - sin(lat1) * sin(lat2))
            return CLLocationCoordinate2D(latitude: lat2 * 180 / Double.pi, longitude: lon2 * 180 / Double.pi)
        }

        let firstLocation = CLLocation(latitude: 0.0, longitude: 0.0)
        var lastLocation = firstLocation
        DispatchQueue.main.asyncAfter(deadline: delay) {
            print("LocationClient started with reaching distance mock")
            let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                let location = CLLocation(
                    coordinate: locationWithBearing(
                        bearingRadians: 0.0,
                        distanceMeters: speedInMeters,
                        origin: lastLocation.coordinate
                    ),
                    altitude: 0.0,
                    horizontalAccuracy: 0.0,
                    verticalAccuracy: 0.0,
                    course: 0.0,
                    speed: speedInMeters,
                    timestamp: Date()
                )
                if location.distance(from: firstLocation) >= distanceInMeters {
                    print(
                        "Distance reached at \(location.distance(from: firstLocation)), locationClient stopping now."
                    )
                    timer.invalidate()
                }

                lastLocation = location
                subject.send(.didUpdateLocations([location]))
            }
        }

        return Self(
            authorizationStatus: { .authorizedWhenInUse },
            requestAlwaysAuthorization: {},
            requestLocation: {
                subject.send(.didUpdateLocations([CLLocation()]))
            },
            mostRecentLocation: { nil },
            startUpdatingLocation: {},
            delegate: subject
                .share()
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        )
    }
}
