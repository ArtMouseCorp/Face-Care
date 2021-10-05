import Foundation

struct Article: Codable {
    
    let id: Int
    let title: String
    let image: String
    let text: String
    
    public static var all: [Article] = []
    
    public static let `default` = Article(id: 0, title: "Title", image: "image", text: "Text")
    
    public static func getAll() {
        
        self.all.removeAll()
        guard let jsonData = readLocalJSONFile(forName: "articles_\(State.shared.getLanguage().rawValue)") else { return }
        
        do {
            let decodedData = try JSONDecoder().decode(Article.Response.self, from: jsonData)
            self.all = decodedData.articles
        } catch {
            print("Error: ", error)
        }
    }
    
    internal struct Response: Codable {
        let articles: [Article]
    }
    
}

/*
 //           _._
 //        .-'   `
 //      __|__
 //     /     \
 //     |()_()|
 //     \{o o}/
 //      =\o/=
 //       ^ ^
 */
