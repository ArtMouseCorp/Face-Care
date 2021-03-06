import UIKit
import PanModal

class ExerciseInfoPopup: BasePopupViewController {

    // MARK: - @IBOutlets
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    // Constraints
    @IBOutlet weak var descriptionLabelHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Variables
    
    var popupHeight: CGFloat = 24 + 0 + 24 + 0 + 24 // without titleLabel & descriptionLabel height
    var onCloseCompletion: ((_ currentItem: Int)->()) = {_  in }
    
    var currentItem = 0
    var exercises: [Exercise] = []
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        
        titleLabel.text = exercises[currentItem].name
        descriptionLabel.text = exercises[currentItem].description
        
        checkChevrons()
        
        descriptionLabelHeightConstraint.constant = descriptionLabel.contentHeight(lineSpacing: 4)
        
        super.setPopupHeight(popupHeight + titleLabel.contentHeight(lineSpacing: 4) + descriptionLabelHeightConstraint.constant)
        super.panModalSetNeedsLayoutUpdate()
        
        descriptionLabel.textAlignment = .center
        titleLabel.textAlignment = .center
        nextButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
    
    private func checkChevrons() {
        prevButton.isHidden = currentItem == 0
        nextButton.isHidden = currentItem == exercises.count - 1
    }
    
    override func panModalDidDismiss() {
        onCloseCompletion(currentItem)
    }
    
    // MARK: - @IBActions
    
    @IBAction func prevButtonPressed(_ sender: Any) {
        currentItem -= 1
        configureUI()
        super.panModalTransition(to: .shortForm)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        currentItem += 1
        configureUI()
        super.panModalTransition(to: .shortForm)
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
