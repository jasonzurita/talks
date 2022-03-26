import Swift

// inspired by:
// https://github.com/kickstarter/ios-oss/blob/f6e63b39deeaba23cb35f7b2f01da6918d5721bd/Library/Language.swift

public enum Language: String, CaseIterable {
    case en
    case es

    public var displayString: String {
        switch self {
        case .en: return "English"
        case .es: return "Spanish"
        }
    }

    public init?(languageStrings languages: [String]) {
        guard let language = languages
            .lazy
            .compactMap(Language.init(rawValue:))
            .first
        else {
            return nil
        }
        self = language
    }
}
