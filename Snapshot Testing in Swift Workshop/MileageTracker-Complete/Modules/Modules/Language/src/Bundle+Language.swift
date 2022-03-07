import Foundation

public extension Bundle {
    func bundle(for language: Language) -> Bundle? {
        path(forResource: language.rawValue, ofType: "lproj")
            .flatMap(Bundle.init(path:))
    }
}
