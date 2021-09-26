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
    
    var exercisePack: [Exercise] = []
    var endExerciseCompletion: (()->()) = {}
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exercisePack.append(Exercise.examples[0])
        exercisePack.append(Exercise.examples[1])
        exercisePack.append(Exercise.examples[2])
        exercisePack.append(Exercise.examples[3])
        
        trainingNameLabel.text = exercisePack[0].name
        trainingDescriptionLabel.text = exercisePack[0].description
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        trainingInfoView.roundCorners(radius: 32, corners: .topLeft, .topRight)
        startButton.configure(as: .filled)
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
        exerciseLoading.exercisePack = exercisePack
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
