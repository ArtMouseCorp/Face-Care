import UIKit

extension UIView {
    
    func roundCorners(radius: CGFloat, corners: UIRectCorner...) {
        layer.cornerRadius = radius
        var cornerMask: CACornerMask = CACornerMask()
        corners.forEach { corner in
            cornerMask.insert(CACornerMask(rawValue: corner.rawValue))
        }
        layer.maskedCorners = cornerMask
    }
    
    func capsuleCorners(corners: UIRectCorner) {
        self.roundCorners(radius: self.frame.height / 2, corners: corners)
    }
    
    func setBorder(width: CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    func addTapGesture(action: Selector) {
        let tapGesture = UITapGestureRecognizer(target: self.parentContainerViewController(), action: action)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
    }
    
    func flash() {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.1
        flash.fromValue = 1
        flash.toValue = 0.6
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 1
        layer.add(flash, forKey: nil)
    }
    
    func hide() {
        self.isHidden = true
    }
    
    func hide(_ hide: Bool) {
        self.isHidden = hide
    }
    
    func show() {
        self.isHidden = false
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
