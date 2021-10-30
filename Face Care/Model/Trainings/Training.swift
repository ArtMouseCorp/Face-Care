import Foundation

class Training: Codable {
    
    var name: String
    var description: String
    let duration: Int
    let exercises: [Exercise]
    
    init(name: String, description: String, duration: Int, exercises: [Exercise]) {
        self.name = name
        self.description = description
        self.duration = duration
        self.exercises = exercises
    }
    
    public static let `default` = Training(name: "Training", description: "Training description", duration: 7, exercises: [])

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
