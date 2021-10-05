import UIKit

class FCButton: UIButton {
    
    // MARK: - Variables
    
    private var type: FCButtonType = .filled
    
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
        
        self.type = type
        
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
    
    public func disable(_ disable: Bool = true) {
        
        self.isEnabled = !disable
        
        switch type {
        case .filled:
            
            self.backgroundColor = .FCIris.withAlphaComponent(disable ? 0.6 : 1)
            self.setTitleColor(.FCWhite, for: .normal)
            
        case .outlined:
            
            self.backgroundColor = .clear
            self.setTitleColor(.FCDarkCharcoal.withAlphaComponent(disable ? 0.6 : 1), for: .normal)
            self.setBorder(width: 1, color: .FCBlack.withAlphaComponent(disable ? 0.6 : 1))
            
        }
    }
    
    public func enable() {
        self.disable(false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        flash()
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
