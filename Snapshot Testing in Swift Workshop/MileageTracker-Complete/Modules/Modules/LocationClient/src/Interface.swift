import Combine
import CoreLocation

public struct LocationClient {
    public var authorizationStatus: () -> CLAuthorizationStatus
    public var requestAlwaysAuthorization: () -> Void
    public var requestLocation: () -> Void
    public var mostRecentLocation: () -> CLLocation?
    public var startUpdatingLocation: () -> Void
    public var delegate: AnyPublisher<DelegateEvent, Never> // swiftlint:disable:this weak_delegate

    public init(
        authorizationStatus: @escaping () -> CLAuthorizationStatus,
        requestAlwaysAuthorization: @escaping () -> Void,
        requestLocation: @escaping () -> Void,
        mostRecentLocation: @escaping () -> CLLocation?,
        startUpdatingLocation: @escaping () -> Void,
        delegate: AnyPublisher<DelegateEvent, Never>
    ) {
        self.authorizationStatus = authorizationStatus
        self.requestAlwaysAuthorization = requestAlwaysAuthorization
        self.requestLocation = requestLocation
        self.mostRecentLocation = mostRecentLocation
        self.startUpdatingLocation = startUpdatingLocation
        self.delegate = delegate
    }

    public enum DelegateEvent {
        case didChangeAuthorization(CLAuthorizationStatus)
        case didUpdateLocations([CLLocation])
        case didFailWithError(Error)
    }
}
