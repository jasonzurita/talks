import Combine
import MTWorld

public final class RootViewModel: ObservableObject {
    @Published var hasLocationPermission: Bool
    private var locationEventCancellable: AnyCancellable?

    public init() {
        Current.locationClient.startUpdatingLocation()
        hasLocationPermission = [
            .authorizedWhenInUse,
            .authorizedAlways,
        ].contains(Current.locationClient.authorizationStatus())

        locationEventCancellable = Current.locationClient.delegate.sink { [weak self] event in
            guard let self = self else { return }
            switch event {
            case let .didChangeAuthorization(status):
                self.hasLocationPermission = [.authorizedWhenInUse, .authorizedAlways].contains(status)
            case .didUpdateLocations, .didFailWithError:
                break
            }
        }
    }
}
