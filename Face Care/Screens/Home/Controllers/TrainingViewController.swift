import UIKit

class TrainingViewController: BaseViewController {

    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var trainingInfoView: UIView!
    
    // Labels
    @IBOutlet weak var trainingNameLabel: UILabel!
    @IBOutlet weak var trainingDurationLabel: UILabel!
    @IBOutlet weak var trainingDescriptionLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var startButton: FCButton!
    
    // Image Views
    @IBOutlet weak var trainingImageView: UIImageView!
    
    // MARK: - Variables
    
    var training: Training = .default
    var endExerciseCompletion: (()->()) = {}
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        localize()
        configureUI()
        State.shared.setCurrentScreen(to: "Training Screen")
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        trainingInfoView.roundCorners(radius: 32, corners: .topLeft, .topRight)
        startButton.configure(as: .filled)
        
        trainingNameLabel.text = training.name
        
        let minutesNounKey = getNoun(
            number: training.duration,
            one: L.Home.Duration.Minutes.one,
            two: L.Home.Duration.Minutes.two,
            five: L.Home.Duration.Minutes.five
        )
        let duration = L.get(key: minutesNounKey, args: training.duration)
        
        trainingDurationLabel.text = duration
        trainingDescriptionLabel.text = training.description
        trainingDescriptionLabel.textAlignment = .center
    }
    
    private func localize() {
        startButton.localize(with: L.Training.start)
    }
    
    // MARK: - @IBActions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func startButtonPressed(_ sender: Any) {
        let exerciseLoading = ExerciseLoadingViewController.load(from: Screen.exerciseLoading)
        exerciseLoading.onDismiss = { isEnded in
            if !isEnded {
                self.navigationController?.popViewController(animated: false)
            } else {
                self.navigationController?.popViewController(animated: false)
                self.endExerciseCompletion()
            }
        }
        exerciseLoading.exercisePack = training.exercises
        exerciseLoading.modalPresentationStyle = .fullScreen
        exerciseLoading.modalTransitionStyle = .crossDissolve
        self.present(exerciseLoading, animated: true)
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
