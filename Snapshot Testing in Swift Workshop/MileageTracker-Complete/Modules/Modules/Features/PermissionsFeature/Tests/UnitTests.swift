import Foundation
@testable import MTPermissionsFeature
import MTWorld
import SnapshotTesting
import XCTest

final class UnitTests: XCTestCase {
    override func setUp() {
        super.setUp()
        Current = .mock
    }

    func testSnapshotPermissionsView() {
        // given
        let view = PermissionsView()

        let imageConfigs: [ViewImageConfig] = [
            .iPhoneXr,
            .iPadMini,
            .iPhone8,
            .iPhone8Plus,
            .iPhoneSe,
            .iPhoneX(.landscape),
            .iPhoneXsMax(.landscape),
        ]

        // when
        imageConfigs
            .map(SwiftUISnapshotLayout.device(config:))
            // then
            .forEach {
                assertSnapshot(matching: view, as: .image(layout: $0))
            }
    }
}
