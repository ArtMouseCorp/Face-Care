import Foundation

struct Category: Codable {
    
    let name: String
    let exercises: [Exercise]
    
    internal struct JSONResponse: Codable {
        let categories: [Category]
    }
    
    public static var all: [Category] = []
    public static let `default`: Category = Category(name: "", exercises: [])
    
//    public static func parseAll() {
//
//        self.all.removeAll()
//
//        let jsonData = readLocalJSONFile(forName: "presets")!
//        do {
//            let decodedData = try JSONDecoder().decode([Preset].self, from: jsonData)
//            self.all = decodedData
//        } catch {
//            print("error: \(error)")
//        }
//
//    }
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
