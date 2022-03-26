// main init
init() {
    Current.locationClient = .notDetermined
}

// dependency
.package(
    name: "SnapshotTesting",
    url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
    from: "1.9.0"
)

// root view, integration tests
func testGrantPermissionsFlow() {
    // given
    var status = CLAuthorizationStatus.notDetermined
    let subject = PassthroughSubject<LocationClient.DelegateEvent, Never>()
    Current.locationClient = LocationClient(
        authorizationStatus: { status },
        requestAlwaysAuthorization: { },
        requestLocation: { },
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



// permissions view

Image("girl-in-car-with-dog", bundle: .module)
    .resizable()
    .aspectRatio(contentMode: .fit)
    .padding([.leading, .trailing])

// tests
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
        .iPhoneXsMax(.landscape)
    ]

    // when
    imageConfigs
        .map(SwiftUISnapshotLayout.device(config:))
    // then
        .forEach {
            assertSnapshot(matching: view, as: .image(layout: $0))
        }
}

// Summary view tests
static func formatDate(forHeader date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM d, yyyy"
    return formatter.string(from: date)
}

static func uploadRequest(for locations: [CLLocation], to url: URL) -> URLRequest? {
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    let requestDictionary = locations.enumerated().reduce(into: [:]) { partialResult, element in
        partialResult["\(element.offset)"] = [
            "lat": "\(element.element.coordinate.latitude)",
            "long": "\(element.element.coordinate.longitude)"
        ]
    }
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: requestDictionary, options: .prettyPrinted)
    } catch {
        return nil
    }
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    return request
}

NSLocalizedString(
    "miles-driven",
    bundle: Bundle.module.bundle(for: Current.language) ?? .module,
    comment: "Label stating the distance driven in a vehicle"
)

NSLocalizedString(
    "mileage",
    bundle: Bundle.module.bundle(for: Current.language) ?? .module,
    comment: "Title of mileage, which is a distance that a vehicle was driven"
)

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


// Custom snapshot strategy

func testSnapshotLocationUpload() {
    // given
    let locations = [CLLocation(latitude: 0, longitude: 0), CLLocation(latitude: 1, longitude: 1)]
    let url = URL(string: "https://tryswift.com/location-upload")!

    // when
    let request = SummaryViewHelpers.uploadRequest(for: locations, to: url)

    // then
    assertSnapshot(matching: request!, as: .rawWithSortedBody)
}

// Copied and modified from the Snapshotting library from the .pretty(:) snapshot strategy
extension Snapshotting where Value == URLRequest, Format == String {
    public static var rawWithSortedBody: Snapshotting {
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
            }
            catch {
                XCTFail("Failed to pretty print body")
                body = []
            }

            return ([method] + headers + body).joined(separator: "\n")
        }
    }
}
