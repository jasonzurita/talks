import Foundation

/*
 Below is from: https://github.com/lukePeavey/quotable
 {
    "length" : 76,
    "_id" : "VDDodhULiss2",
    "content" : "It is through science that we prove, but through intuition that we discover.",
    "tags" : [
       "famous-quotes",
       "science",
       "technology"
    ],
    "authorSlug" : "henri-poincare",
    "author" : "Henri Poincaré"
 }
 */

struct Quote: Codable {
    let length: Int
    let id, content: String
    let tags: [String]
    let authorSlug, author: String

    enum CodingKeys: String, CodingKey {
        case length
        case id = "_id"
        case content, tags, authorSlug, author
    }
}
