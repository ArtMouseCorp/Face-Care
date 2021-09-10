import UIKit

class ExercisesViewController: UIViewController {

    // MARK: - @IBOutlets
        
    // Views
    @IBOutlet weak var circleVideoProgressView: UIView!
    @IBOutlet weak var currentProgressView: UIView!
    @IBOutlet weak var allProgressView: UIView!
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    // Image Views
    @IBOutlet weak var mainImage: UIImageView!
    
    // Stack views
    @IBOutlet weak var stackView: UIStackView!
    
    // ...
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let exrecisePopup = ExercisePopupViewController.load(from: Popup.exercises)
        presentPanModal(exrecisePopup)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
        setupGestures()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        for view in stackView.subviews {
            view.layer.cornerRadius = view.frame.height / 2
        }
        backButton.isHidden = true
        circleVideoProgressView.layer.cornerRadius = 8
        currentProgressView.layer.cornerRadius = currentProgressView.frame.height / 2
        allProgressView.layer.cornerRadius = allProgressView.frame.height / 2
    }
    
    private func configureOnPopup(isHidden: Bool = true) {
        stackView.isHidden = !isHidden
        closeButton.isHidden = !isHidden
        titleLabel.isHidden = !isHidden
        backButton.isHidden = isHidden
    }
    
    private func setupGestures() {
        
    }
    
    // MARK: - Gesture actions
    
    // MARK: - @IBActions
    
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
