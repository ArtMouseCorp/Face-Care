import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var cellBackgroundView: UIView!
    
    // Labels
    @IBOutlet weak var articleTitleLabel: UILabel!
    
    // Image Views
    @IBOutlet weak var articleImageView: UIImageView!
    
    // Constraints
    @IBOutlet weak var articleImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var cellTopConstraint: NSLayoutConstraint!
    
    // MARK: - Variables
    
    // MARK: - Awake functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func prepareForReuse() {
        articleImageView.image = UIImage()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        cellBackgroundView.roundCorners(radius: 16, corners: .allCorners)
        cellBackgroundView.clipsToBounds = true
        
        articleImageViewHeightConstraint.constant = min((UIScreen.main.bounds.width - 32) / 1.2035087719, 600)
        
        DispatchQueue.main.async {
            
            let gradient = CAGradientLayer()
            
            gradient.frame = self.articleImageView.frame
            
            gradient.colors = [
                UIColor.FCBlack.withAlphaComponent(0).cgColor,
                UIColor.FCBlack.withAlphaComponent(0.5).cgColor
            ]
            gradient.locations = [0.5, 1]
            
            self.articleImageView.layer.addSublayer(gradient)
        }
        
    }
    
    public func initialize(title: String, image: UIImage?) {
        articleTitleLabel.text = title
        articleImageView.image = image
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
