import Combine
import CoreLocation
@testable import MTApp
import MTLocationClient
import MTWorld
import SwiftUI
import XCTest

final class IntegrationTests: XCTestCase {
    override func setUp() {
        super.setUp()
        Current = .mock
    }
}
