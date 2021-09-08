import UIKit

class DailyTrainingCollectionViewCell: UICollectionViewCell {
    
    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var dayBackgroundView: UIView!
    @IBOutlet weak var startBackgroundView: UIView!
    
    // Labels
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    
    // Image Views
    @IBOutlet weak var trainingImageView: UIImageView!
    
    // MARK: - Variables
    
    // MARK: - Awake functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        self.contentView.clipsToBounds = false
        self.contentView.layer.masksToBounds = false
        
        cellBackgroundView.layer.masksToBounds = false
        cellBackgroundView.roundCorners(radius: 12, corners: .allCorners)
        cellBackgroundView.layer.shadowColor = UIColor.FCBlack.withAlphaComponent(0.35).cgColor
        cellBackgroundView.layer.shadowOpacity = 1
        cellBackgroundView.layer.shadowRadius = 12
        cellBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        dayBackgroundView.roundCorners(radius: 8, corners: .allCorners)
        
        startBackgroundView.roundCorners(radius: 12, corners: .bottomLeft, .bottomRight)
        
        let gradient = CAGradientLayer()
        
        gradient.frame = trainingImageView.frame

        gradient.colors = [
            UIColor.FCWhite.withAlphaComponent(0).cgColor,
            UIColor.FCWhite.withAlphaComponent(1).cgColor
        ]
        gradient.locations = [0.55, 1]

        trainingImageView.layer.addSublayer(gradient)
    }
    
    public func configure(name: String, day: String, duration: String, image: UIImage) {
        
        nameLabel.text = name
        dayLabel.text = day
        durationLabel.text = duration
        trainingImageView.image = image
        
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
