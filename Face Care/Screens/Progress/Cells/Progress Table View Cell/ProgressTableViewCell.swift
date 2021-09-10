import UIKit

class ProgressTableViewCell: UITableViewCell {

    // MARK: - @IBOutlets
        
    // Views
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var insideProgressView: UIView!
    
    // Labels
    @IBOutlet weak var statLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    // Constraints
    @IBOutlet weak var progressWidthConstraint: NSLayoutConstraint!
    
    // MARK: - Awake functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        progressView.capsuleCorners(corners: .allCorners)
        insideProgressView.capsuleCorners(corners: .allCorners)
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
