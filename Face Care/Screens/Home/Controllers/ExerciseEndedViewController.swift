import UIKit
import AVFoundation

class ExerciseEndedViewController: BaseViewController {

    // MARK: - @IBOutlets
        
    // Views
    @IBOutlet weak var popupView: UIView!
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var makePhotoButton: FCButton!
    @IBOutlet weak var continueButton: FCButton!
    
    // Image Views
    @IBOutlet weak var mainImage: UIImageView!
    
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
        popupView.roundCorners(radius: 32, corners: .topLeft, .topRight)
        makePhotoButton.configure(as: .filled)
        continueButton.configure(as: .filled)
        makePhotoButton.backgroundColor = UIColor(red: 161/255, green: 83/255, blue: 148/255, alpha: 1)
    }
    
    // MARK: - @IBActions
    
    @IBAction func makePhotoButtonPressed(_ sender: Any) {
        super.takePhoto()
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
