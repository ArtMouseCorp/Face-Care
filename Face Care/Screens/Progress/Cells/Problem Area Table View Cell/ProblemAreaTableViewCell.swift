import UIKit

class ProblemAreaTableViewCell: UITableViewCell {

    // MARK: - @IBOutlets
    
    // Labels
    @IBOutlet weak var nameLabel: UILabel!
    
    // Image Views
    @IBOutlet weak var checkboxImageView: UIImageView!
    
    // MARK: - Awake functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Custom functions
    
    public func configure(name: String, isChecked: Bool) {
        self.nameLabel.text = name
        self.checkboxImageView.image = isChecked ? .FCCheckedCheckbox : .FCEmptyCheckbox
    }
    
    public func select() {
        self.checkboxImageView.image = .FCCheckedCheckbox
    }
    
    public func deselect() {
        self.checkboxImageView.image = .FCEmptyCheckbox
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
