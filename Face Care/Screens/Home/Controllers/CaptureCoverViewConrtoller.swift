import UIKit

class CaptureCoverViewConrtoller: BaseViewController {

    // MARK: - @IBOutlets
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        localize()
    }
    
    // MARK: - Custom functions
    
    private func localize() {
        self.titleLabel.localize(with: L.Training.CaptureCover.title)
        self.descriptionLabel.localize(with: L.Training.CaptureCover.description)
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
