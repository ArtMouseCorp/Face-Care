import UIKit
import AVFoundation

class ExerciseLoadingViewController: BaseViewController {
    
    // MARK: - @IBOutlets
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    
    // Image Views
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    // MARK: - Variables
    
    var exerciseName: String = ""
    var exerciseNumber: Int = 0
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
        State.shared.setCurrentScreen(to: "Exercise Loading Screen")
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        titleLabel.text = L.get(key: L.Training.exercise, args: exerciseNumber, exerciseName)
    }
    
    public func remove() {
        self.view.removeFromSuperview()
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
