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
    
    // StackViews
    @IBOutlet weak var durationStackView: UIStackView!
    
    // MARK: - Variables
    
    var training: Training = .default
    var dayNumber: Int?
    var isDurationHidden: Bool = false
    
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
        
        durationStackView.isHidden = isDurationHidden
        
        trainingNameLabel.text = training.name
        trainingImageView.image = training.exercises.first?.getImage() ?? UIImage()
        
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
        
        let exerciseVC = ExerciseViewController.load(from: Screen.exercise)
        
        exerciseVC.exercises = training.exercises
        exerciseVC.trainingNumber = dayNumber
        exerciseVC.modalPresentationStyle = .fullScreen
        exerciseVC.modalTransitionStyle = .crossDissolve
        
        self.present(exerciseVC, animated: true) {
            self.navigationController?.popViewController(animated: false)
        }
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
