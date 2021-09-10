import UIKit

extension UIImageView {
    
    public func whiteGradient(locations: [NSNumber], opacity: Float) {
        
        let gradient = CAGradientLayer()
        
        gradient.frame = self.frame

        gradient.colors = [
            UIColor.FCWhite.withAlphaComponent(0).cgColor,
            UIColor.FCWhite.withAlphaComponent(1).cgColor
        ]
        gradient.locations = [0.55, 1]
        gradient.opacity = 1
        self.layer.addSublayer(gradient)
        
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
