import Foundation

struct FaceArea: Codable {
    
    let id: Int
    let name: String
    let exercises: [Exercise]
    
    public static var all: [FaceArea] = []
    
    public static func getAll() {
        
        self.all.removeAll()
        guard let jsonData = readLocalJSONFile(forName: "faceAreas_\(State.shared.getLanguage().rawValue)") else { return }
        
        do {
            let decodedData = try JSONDecoder().decode(FaceArea.Response.self, from: jsonData)
            self.all = decodedData.faceAreas
        } catch {
            print("Error: ", error)
        }
    
    }
    
    internal struct Response: Codable {
        let faceAreas: [FaceArea]
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
