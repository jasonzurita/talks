import CoreLocation
import Foundation

enum SummaryViewHelpers {
    static func formatDate(forHeader date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter.string(from: date)
    }

    static func formatDate(forList date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy 'at' h:mm a"
        return formatter.string(from: date)
    }

    static func uploadRequest(for locations: [CLLocation], to url: URL) -> URLRequest? {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let requestDictionary = locations.enumerated().reduce(into: [:]) { partialResult, element in
            partialResult["\(element.offset)"] = [
                "lat": "\(element.element.coordinate.latitude)",
                "long": "\(element.element.coordinate.longitude)",
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
}
