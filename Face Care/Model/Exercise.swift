import Foundation
import UIKit

class Exercise: Codable {
    
    let id: Int
    var name: String
    var description: String
    let duration: Int
    private let image: String
    private var url: String

    public func getVideoURL(completion: ((URL) -> ())) {
        if let url = URL(string: self.url) {
            completion(url)
        }
    }
    
    public func getImage() -> UIImage {
        return UIImage(named: self.image) ?? UIImage()
    }
    
    public func getVideoURL() -> URL {
        guard let url = URL(string: self.url) else { fatalError() }
        return url
    }
    
    public func localize(from localizedExercise: Exercise) {
        self.name = localizedExercise.name
        self.description = localizedExercise.description
        self.url = localizedExercise.url
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
