import MTPermissionsFeature
import MTSummaryFeature
import MTWorld
import SwiftUI

public struct RootView: View {
    @ObservedObject private var viewModel: RootViewModel
    public init(viewModel: RootViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        if viewModel.hasLocationPermission {
            MileageSummaryView(viewModel: .mock)
        } else {
            PermissionsView()
        }
    }
}
