import UIKit

class ProgressSettingsViewController: BaseViewController {

    // MARK: - @IBOutlets
        
    // Views
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var eyesView: UIView!
    @IBOutlet weak var foreheadView: UIView!
    @IBOutlet weak var neckView: UIView!
    @IBOutlet weak var chinView: UIView!
    @IBOutlet weak var cheecksView: UIView!
    
    // Labels
    @IBOutlet weak var mainLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var resetProgressButton: FCButton!
    
    // Image Views
    @IBOutlet weak var eyesViewCheckmark: UIImageView!
    @IBOutlet weak var foreheadViewCheckmark: UIImageView!
    @IBOutlet weak var neckViewCheckmark: UIImageView!
    @IBOutlet weak var chinViewCheckmark: UIImageView!
    @IBOutlet weak var cheecksViewCheckmark: UIImageView!
    
    // MARK: - Variables
    
    let defaults = UserDefaults.standard
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
        setupGestures()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        mainView.roundCorners(radius: 32, corners: .topLeft, .topRight)
        resetProgressButton.configure(as: .filled)
        setCheckmarks()
    }
    
    private func setCheckmarks() {
        let problemAreaIndexes = defaults.array(forKey: UDKeys.problemAreas) as? [Int] ?? [Int]()
        for index in problemAreaIndexes {
            switch index {
            case 0:
                eyesViewCheckmark.image = UIImage.FCCheckedCheckbox
                break
            case 1:
                foreheadViewCheckmark.image = UIImage.FCCheckedCheckbox
                break
            case 2:
                neckViewCheckmark.image = UIImage.FCCheckedCheckbox
                break
            case 3:
                chinViewCheckmark.image = UIImage.FCCheckedCheckbox
                break
            case 4:
                cheecksViewCheckmark.image = UIImage.FCCheckedCheckbox
                break
            default:
                break
            }
        }
    }
    
    private func setupGestures() {
        eyesView.addTapGesture(target: self, action: #selector(eyesViewTapped))
        foreheadView.addTapGesture(target: self, action: #selector(foreheadViewTapped))
        neckView.addTapGesture(target: self, action: #selector(neckViewTapped))
        chinView.addTapGesture(target: self, action: #selector(chinViewTapped))
        cheecksView.addTapGesture(target: self, action: #selector(cheecksViewTapped))
    }
    
    // MARK: - Gesture actions
    
    @objc func eyesViewTapped() {
        
    }
    
    @objc func foreheadViewTapped() {
        
    }
    
    @objc func neckViewTapped() {
        
    }
    
    @objc func chinViewTapped() {
        
    }
    
    @objc func cheecksViewTapped() {
        
    }
    
    // MARK: - @IBActions
    @IBAction func backButtonPressed(_ sender: Any) {
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
