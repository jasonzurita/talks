import MTLanguage
import MTWorld
import SwiftUI

public struct MileageSummaryView: View {
    @ObservedObject private var viewModel: MileageSummaryViewModel

    public init(viewModel: MileageSummaryViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Spacer()
                Text("Mileage")
                    .font(.title)
                    .padding([.leading, .top])

                Spacer()
                VStack {
                    HStack {
                        Text("\(viewModel.viewData.totalMiles, specifier: "%.0f")")
                            .font(.system(size: 62))
                            .bold()
                        Text("Miles\nDriven")
                        Spacer()
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Total Time: \(viewModel.viewData.totalTime / 60, specifier: "%.0f") minutes")
                            if let last = viewModel.viewData.lastTrip?.dateInterval.start {
                                Text("Last: \(SummaryViewHelpers.formatDate(forList: last))")
                            }
                        }
                        .font(.subheadline)
                        Spacer()
                    }
                }
                .padding([.leading, .trailing])

                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            .background(Color(.sRGB, red: 94 / 255, green: 205 / 255, blue: 154 / 255, opacity: 1))
            .cornerRadius(48, corners: [.bottomLeft, .bottomRight])
            .ignoresSafeArea(.container, edges: .top)

            VStack(alignment: .leading) {
                Text("Trips")
                    .bold()
                    .font(.title)
                    .padding([.leading])

                List(viewModel.viewData.trips) { trip in
                    VStack(alignment: .leading) {
                        HStack {
                            Text("\(trip.miles, specifier: "%.2f") miles")
                            Spacer()
                            Text("\(trip.dateInterval.duration / 60, specifier: "%.2f") minutes")
                        }
                        .font(.title3)
                        Text("\(SummaryViewHelpers.formatDate(forList: trip.dateInterval.start))")
                            .padding(.top, 0)
                            .font(.callout)
                            .foregroundColor(.gray)
                    }
                }
                .listStyle(.plain)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let trips = [
            Trip(miles: 10, dateInterval: DateInterval(start: Date(), duration: 100)),
            Trip(miles: 15, dateInterval: DateInterval(start: Date(), duration: 200)),
            Trip(miles: 16, dateInterval: DateInterval(start: Date(), duration: 150)),
            Trip(miles: 16, dateInterval: DateInterval(start: Date(), duration: 1500)),
        ]
        MileageSummaryView(
            viewModel: MileageSummaryViewModel(
                viewData: MileageSummaryViewData(trips: trips)
            )
        )
    }
}
