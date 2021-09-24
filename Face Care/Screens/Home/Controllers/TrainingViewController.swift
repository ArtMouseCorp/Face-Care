import UIKit

class TrainingViewController: BaseViewController {

    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var trainingInfoView: UIView!
    // Labels
    @IBOutlet weak var trainintNameLabel: UILabel!
    @IBOutlet weak var trainingDurationLabel: UILabel!
    @IBOutlet weak var trainingDescriptionLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var startButton: FCButton!
    
    // Image Views
    @IBOutlet weak var trainingImageView: UIImageView!
    
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
        
        trainingInfoView.roundCorners(radius: 32, corners: .topLeft, .topRight)
        startButton.configure(as: .filled)
    }
    
    // MARK: - Gesture actions
    
    // MARK: - @IBActions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func startButtonPressed(_ sender: Any) {
        let exerciseLoaging = ExerciseLoadingViewController.load(from: Screen.exerciseLoading)
        exerciseLoaging.modalPresentationStyle = .fullScreen
        exerciseLoaging.modalTransitionStyle = .crossDissolve
        self.present(exerciseLoaging, animated: true)
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
