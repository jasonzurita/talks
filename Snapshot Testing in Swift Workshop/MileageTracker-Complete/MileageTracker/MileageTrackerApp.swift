import MTApp
import MTPermissionsFeature
import MTSummaryFeature
import MTWorld
import SwiftUI

@main
struct MileageTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(viewModel: RootViewModel())
        }
    }
}
