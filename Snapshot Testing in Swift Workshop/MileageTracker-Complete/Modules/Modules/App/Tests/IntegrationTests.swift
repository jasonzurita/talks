import Combine
import CoreLocation
@testable import MTApp
import MTLocationClient
import MTWorld
import SnapshotTesting
import SwiftUI
import XCTest

final class IntegrationTests: XCTestCase {
    override func setUp() {
        super.setUp()
        Current = .mock
    }

    func testGrantPermissionsFlow() {
        // given
        var status = CLAuthorizationStatus.notDetermined
        let subject = PassthroughSubject<LocationClient.DelegateEvent, Never>()
        Current.locationClient = LocationClient(
            authorizationStatus: { status },
            requestAlwaysAuthorization: {},
            requestLocation: {},
            mostRecentLocation: { nil },
            startUpdatingLocation: {},
            delegate: subject.eraseToAnyPublisher()
        )

        // when
        let rv = RootView(viewModel: RootViewModel())

        // then
        assertSnapshot(matching: rv, as: .image(layout: .device(config: .iPhoneXr)))

        // when
        status = .authorizedWhenInUse
        subject.send(.didChangeAuthorization(status))

        // then
        assertSnapshot(matching: rv, as: .image(layout: .device(config: .iPhoneXr)))
    }
}
