import UIKit

extension UIButton {

    public func localize(with key: String, args: CVarArg...) {
        self.setTitle(L.get(key: key, args: args), for: .normal)
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
