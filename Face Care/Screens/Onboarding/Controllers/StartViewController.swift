import UIKit

class StartViewController: BaseViewController {

    // MARK: - @IBOutlets
    
    // Labels
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var startButton: FCButton!
    
    // ImageViews
    @IBOutlet weak var imageView: UIImageView!
    
    // Constraints
    @IBOutlet weak var subtitleLabelHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Variables
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        startButton.configure(as: .filled)
        
        subtitleLabel.setLineHeight(lineHeight: 2)
        subtitleLabel.textAlignment = .center
        subtitleLabel.sizeToFit()
        subtitleLabelHeightConstraint.constant = subtitleLabel.frame.height
    }
    
    // MARK: - @IBActions
    
    @IBAction func startButtonPressed(_ sender: Any) {
        let onboarding = OnboardingViewController.load(from: Screen.onboarding)
        onboarding.modalPresentationStyle = .fullScreen
        self.present(onboarding, animated: false)
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
