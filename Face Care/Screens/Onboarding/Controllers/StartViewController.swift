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
        localize()
        configureUI()
        State.shared.setCurrentScreen(to: "Start Screen")
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        startButton.configure(as: .filled)
        
        subtitleLabelHeightConstraint.constant = subtitleLabel.contentHeight(lineSpacing: 2)
        subtitleLabel.textAlignment = .center
    }
    
    private func localize() {
        welcomeLabel.localize(with: L.Onboarding.Start.welcome)
        subtitleLabel.localize(with: L.Onboarding.Start.description)
        startButton.localize(with: L.Onboarding.OnboardingButton.start)
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
