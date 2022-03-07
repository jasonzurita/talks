import CoreLocation
import MTLanguage
@testable import MTSummaryFeature
import MTWorld
import SnapshotTesting
import SwiftUI
import XCTest

final class UnitTests: XCTestCase {
    override func setUp() {
        super.setUp()
        Current = .mock
    }

    func testSnapshotAllLanguages() {
        Language.allCases.forEach {
            // given (https://martinfowler.com/bliki/GivenWhenThen.html)
            Current.language = $0

            // when
            let view = MileageSummaryView(viewModel: .mock)

            // then
            assertSnapshot(matching: view, as: .image(layout: .device(config: .iPhoneXr)))
        }
    }

    func testSnapshotListDateFormat() {
        // given
        let dateUnderTest = Date(timeIntervalSince1970: 123_456_789)

        // when
        let formattedDateUnderTest = SummaryViewHelpers.formatDate(forList: dateUnderTest)

        // then
        assertSnapshot(matching: formattedDateUnderTest, as: .lines)
    }

    func testSnapshotHeaderDateFormat() {
        // given
        let dateUnderTest = Date(timeIntervalSince1970: 123_456_789)

        // when
        let formattedDateUnderTest = SummaryViewHelpers.formatDate(forHeader: dateUnderTest)

        // then
        assertSnapshot(matching: formattedDateUnderTest, as: .lines)
    }

    func testSnapshotLocationUpload() {
        // given
        let locations = [CLLocation(latitude: 0, longitude: 0), CLLocation(latitude: 1, longitude: 1)]
        let url = URL(string: "https://tryswift.com/location-upload")!

        // when
        let request = SummaryViewHelpers.uploadRequest(for: locations, to: url)

        // then
        assertSnapshot(matching: request!, as: .rawWithSortedBody)
    }
}

// Copied and modified from the Snapshotting library from the .pretty(:) snapshot strategy
public extension Snapshotting where Value == URLRequest, Format == String {
    static var rawWithSortedBody: Snapshotting {
        return SimplySnapshotting.lines.pullback { (request: URLRequest) in
            let method = "\(request.httpMethod ?? "GET") \(request.url?.absoluteString ?? "(null)")"

            let headers = (request.allHTTPHeaderFields ?? [:])
                .map { key, value in "\(key): \(value)" }
                .sorted()

            let body: [String]
            do {
                if #available(iOS 11.0, macOS 10.13, tvOS 11.0, *) {
                    body = try request.httpBody
                        .map { try JSONSerialization.jsonObject(with: $0, options: []) }
                        .map { try JSONSerialization.data(withJSONObject: $0, options: [.prettyPrinted, .sortedKeys]) }
                        .map { ["\n\(String(decoding: $0, as: UTF8.self))"] }
                        ?? []
                        .sorted()
                } else {
                    throw NSError(domain: "co.pointfree.Never", code: 1, userInfo: nil)
                }
            } catch {
                XCTFail("Failed to pretty print body")
                body = []
            }

            return ([method] + headers + body).joined(separator: "\n")
        }
    }
}
