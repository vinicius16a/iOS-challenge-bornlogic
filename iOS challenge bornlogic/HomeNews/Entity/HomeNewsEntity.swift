import Foundation
import UIKit

struct NewsAPIResponse: Codable {
    let status: String
    let totalResults: Int?
    let articles: [Article]?
}

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: Date
    let content: String?
}


struct Source: Codable {
    let id: String?
    let name: String
}

//MARK: - error cases

enum FetchError: Error {
    case failed
}

extension DateFormatter {
    static let formatDdMmAa: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        return formatter
    }()
}
