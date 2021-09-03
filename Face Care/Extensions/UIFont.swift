import UIKit

extension UIFont {
    
    public static func ralewayFont(ofSize size: CGFloat, weight: Weight) -> UIFont {
        
        var ralewayWeight: String = "Regular"
    
        switch weight {
            
        case .light:
            ralewayWeight = "Light"
        case .regular:
            ralewayWeight = "Regular"
        case .medium:
            ralewayWeight = "Medium"
        case .semibold:
            ralewayWeight = "SemiBold"
        case .bold:
            ralewayWeight = "Bold"
        default:
            ralewayWeight = "Regular"
        }
        
        return UIFont(name: "Raleway-\(ralewayWeight)", size: size) ?? .systemFont(ofSize: size, weight: weight)
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
