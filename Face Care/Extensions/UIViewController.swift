import UIKit

extension UIViewController {
    
    public static func load(from screen: StoryboardScreen) -> Self {
        return screen.storyboard.instantiateViewController(withIdentifier: screen.id) as! Self
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
