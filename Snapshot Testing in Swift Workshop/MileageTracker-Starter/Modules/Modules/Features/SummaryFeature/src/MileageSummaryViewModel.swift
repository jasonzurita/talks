import MTWorld
import SwiftUI

public final class MileageSummaryViewModel: ObservableObject {
    @Published var viewData: MileageSummaryViewData

    public init(viewData: MileageSummaryViewData) {
        self.viewData = viewData
    }
}

public extension MileageSummaryViewModel {
    static var mock: Self {
        Self(viewData: MileageSummaryViewData(trips: [.mock, .mock, .mock]))
    }
}
