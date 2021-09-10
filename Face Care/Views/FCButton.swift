import UIKit

class FCButton: UIButton {
    
    // MARK: - Variables
    
    internal enum FCButtonType {
        case filled
        case outlined
    }
    
    // MARK: - Awake functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Custom functions
    
    func configure(as type: FCButtonType) {
        
        self.titleLabel?.font = .ralewayFont(ofSize: 16, weight: .medium)
        self.roundCorners(radius: 12, corners: .allCorners)
        
        switch type {
        case .filled:
            
            self.backgroundColor = .FCIris
            self.setTitleColor(.FCWhite, for: .normal)
            
        case .outlined:
            
            self.backgroundColor = .clear
            self.setTitleColor(.FCDarkCharcoal, for: .normal)
            self.setBorder(width: 1, color: .FCBlack)
            
        }
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
