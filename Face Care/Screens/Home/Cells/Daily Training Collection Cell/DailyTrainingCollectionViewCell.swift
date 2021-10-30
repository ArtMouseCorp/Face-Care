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
    
    public func configure(with dailyTraining: Training.Daily) {
        
        let day = L.get(key: L.Home.day, args: dailyTraining.dayNumber)
        
        let minutesNounKey = getNoun(
            number: dailyTraining.training.duration,
            one: L.Home.Duration.Minutes.one,
            two: L.Home.Duration.Minutes.two,
            five: L.Home.Duration.Minutes.five
        )
        let duration = L.get(key: minutesNounKey, args: dailyTraining.training.duration)
        
        nameLabel.text = L.get(key: L.Home.dailyTraining, args: dailyTraining.dayNumber)
        dayLabel.text = day
        durationLabel.text = duration
        trainingImageView.image = dailyTraining.training.exercises.first?.getImage() ?? UIImage()
        
        
        startBackgroundView.backgroundColor = .FCIris.withAlphaComponent(dailyTraining.isOpen() ? 1 : 0.6)
        startLabel.text = dailyTraining.isOpen() ? L.get(key: L.Training.start) : L.get(key: L.Training.completeDay, args: dailyTraining.dayNumber - 1)
        
    }
    
    public func unlock(_ unlock: Bool, dayNumber: Int) {
        
        let unlock = (unlock && isNextTrainingShouldBeOpen()) || (unlock && dayNumber == 1)
        
        startBackgroundView.backgroundColor = .FCIris.withAlphaComponent(unlock ? 1 : 0.6)
        startLabel.text = unlock ? L.get(key: L.Training.start) : L.get(key: L.Training.completeDay, args: dayNumber - 1)
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
