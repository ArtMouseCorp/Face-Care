import Foundation
import UIKit

struct Exercise: Codable {
    
    let id: Int
    let name: String
    let description: String
    let duration: Int
    private let image: String
    private let url: String

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
