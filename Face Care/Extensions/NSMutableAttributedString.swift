import UIKit

extension NSMutableAttributedString {
    
    
    func bold(_ values: [String]) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : UIFont.ralewayFont(ofSize: 16, weight: .bold)
        ]
        
        values.forEach { value in
            self.append(NSAttributedString(string: value, attributes:attributes))
        }
        
        return self
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
