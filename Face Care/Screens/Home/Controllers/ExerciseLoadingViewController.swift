import UIKit
import AVFoundation

class ExerciseLoadingViewController: BaseViewController {
    
    // MARK: - @IBOutlets
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    
    // Image Views
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    // MARK: - Variables
    
    var currentItem = 0
    var onDismiss: ((_ isEnded: Bool)->()) = {_ in}
    var exercisePack: [Exercise]!
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
        loadVideo()
        State.shared.setCurrentScreen(to: "Exercise Loading Screen")
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        if currentItem <= exercisePack.count - 1 {
            titleLabel.text = "Упражнение \(currentItem + 1): \n\(exercisePack[currentItem].name)"
        } else {
            titleLabel.text = ""
        }
    }
    
    private func loadVideo() {
        
        let exercise = exercisePack[currentItem]
        
        var player = AVPlayer()
        
        
        player = AVPlayer(url: exercise.getVideoURL())
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let exerciseVC = ExerciseViewController.load(from: Screen.exercise)
            exerciseVC.player = player
            exerciseVC.onDismiss = { index, isDismiss, isEnded in
                
                // All exercises are ended
                if isEnded {
                    self.dismiss(animated: false) {
                        self.onDismiss(true)
                    }
                }
                // Dismiss from alert
                else if isDismiss {
                    self.dismiss(animated: false) {
                        self.onDismiss(false)
                    }
                }
                // Go to the next exercise
                else {
                    self.currentItem = index
                    self.configureUI()
                    self.loadVideo()
                }
            }
            exerciseVC.exercisePack = self.exercisePack
            exerciseVC.currentItem = self.currentItem
            exerciseVC.modalPresentationStyle = .fullScreen
            exerciseVC.modalTransitionStyle = .crossDissolve
            self.present(exerciseVC, animated: false)
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
