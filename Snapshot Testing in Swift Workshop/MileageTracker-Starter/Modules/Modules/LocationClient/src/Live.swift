import Combine
import CoreLocation

// swiftlint:disable nesting
public extension LocationClient {
    static func live(accuracy: CLLocationAccuracy) -> Self {
        assert(Thread.isMainThread, "LocationClient should be initialized on the main thread.")

        class Delegate: NSObject, CLLocationManagerDelegate {
            let subject: PassthroughSubject<DelegateEvent, Never>

            init(subject: PassthroughSubject<DelegateEvent, Never>) {
                self.subject = subject
            }

            func locationManager(_: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
                subject.send(.didChangeAuthorization(status))
            }

            func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                subject.send(.didUpdateLocations(locations))
            }

            func locationManager(_: CLLocationManager, didFailWithError error: Error) {
                subject.send(.didFailWithError(error))
            }
        }

        let locationManager = CLLocationManager()
        let subject = PassthroughSubject<DelegateEvent, Never>()
        var delegate: Delegate?
        locationManager.desiredAccuracy = accuracy

        return Self(
            authorizationStatus: { locationManager.authorizationStatus },
            requestAlwaysAuthorization: locationManager.requestAlwaysAuthorization,
            requestLocation: locationManager.requestLocation,
            mostRecentLocation: { locationManager.location },
            startUpdatingLocation: {
                guard delegate == nil else { return }
                delegate = Delegate(subject: subject)
                locationManager.delegate = delegate
                locationManager.startUpdatingLocation()
            },
            delegate: subject
                .share()
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        )
    }
}
