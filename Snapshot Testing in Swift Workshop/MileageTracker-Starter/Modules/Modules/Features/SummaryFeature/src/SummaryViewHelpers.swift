import CoreLocation
import Foundation

enum SummaryViewHelpers {
    static func formatDate(forList date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy 'at' h:mm a"
        return formatter.string(from: date)
    }
}
