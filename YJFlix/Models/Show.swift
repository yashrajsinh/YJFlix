import CoreData
import Foundation

struct Show: Codable {
    let id: Int
    let name: String
    let summary: String?
    let image: Image?

    struct Image: Codable {
        let medium: String?
    }
}
