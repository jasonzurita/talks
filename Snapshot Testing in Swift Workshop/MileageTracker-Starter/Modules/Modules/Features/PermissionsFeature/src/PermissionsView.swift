import MTWorld
import SwiftUI

public struct PermissionsView: View {
    public init() {}
    public var body: some View {
        VStack {
            Spacer()
            Text("Welcome.")
                .font(.largeTitle)
                .bold()
                .padding([.top, .bottom])
            Text("We use location services to automatically track when and how far you drive. Without it, this app is just a car without wheels.")
                .padding([.leading, .trailing])
            Spacer()
            Button("Allow Access to Location") {
                Current.locationClient.requestAlwaysAuthorization()
            }
            Spacer()
        }
    }
}
