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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var problemAreasTitleLabel: UILabel!
    @IBOutlet var problemAreasLabels: [UILabel]!
    @IBOutlet weak var resetProgressLabel: UILabel!
    
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
    
    var problemAreas = State.shared.getProblemAreas()
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        localize()
        configureUI()
        setupGestures()
        State.shared.setCurrentScreen(to: "Progress Settings Screen")
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        mainView.roundCorners(radius: 32, corners: .topLeft, .topRight)
        resetProgressButton.configure(as: .filled)
        setCheckmarks()
    }
    
    private func localize() {
        titleLabel.localize(with: L.Progress.Settings.title)
        problemAreasTitleLabel.localize(with: L.Progress.Settings.problemAreas)
        resetProgressLabel.localize(with: L.Progress.Settings.resetDescription)
        resetProgressButton.localize(with: L.Progress.Settings.ProgressButton.resetProgress)
    }
    
    private func setCheckmarks() {
        let problemAreaIds = State.shared.getProblemAreas()
        for id in problemAreaIds {
            switch id {
            case 1:
                eyesViewCheckmark.image = UIImage.FCCheckedCheckbox
                break
            case 2:
                foreheadViewCheckmark.image = UIImage.FCCheckedCheckbox
                break
            case 3:
                neckViewCheckmark.image = UIImage.FCCheckedCheckbox
                break
            case 4:
                chinViewCheckmark.image = UIImage.FCCheckedCheckbox
                break
            case 5:
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
    
    private func showConfirmationAlert(message: String, confirmButton: String, completion: @escaping (() -> ())) {
        
        let generateAction = UIAlertAction(title: confirmButton, style: .default) { _ in
            completion()
        }
        
        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel)
        
        let alert = getAlert(title: "Вы уверены?", message: message, actions: generateAction, cancelAction)
        
        self.present(alert, animated: true)
        
    }
    
    private func showPlanGenerationAlert(completion: @escaping (() -> ())) {
        self.showConfirmationAlert(message: "Ваш персональный курс будет сгенерировать заново и вы сможете начать сначала", confirmButton: "Сгенерировать") {
            completion()
        }
    }
    
    private func addProblemArea(_ element: Int) {
        self.problemAreas.append(element)
    }
    
    private func removeProblemArea(_ element: Int) {
        if let index = self.problemAreas.firstIndex(of: element) {
            self.problemAreas.remove(at: index)
        }
    }
    
    // MARK: - Gesture actions
    
    @objc func eyesViewTapped() {
        self.showPlanGenerationAlert {
            
            let faceAreaId = 1
            let isEnabled = self.problemAreas.contains(faceAreaId)
            isEnabled ? self.removeProblemArea(faceAreaId) : self.addProblemArea(faceAreaId)
            self.eyesViewCheckmark.image = isEnabled ? .FCEmptyCheckbox : .FCCheckedCheckbox
            
        }
    }
    
    @objc func foreheadViewTapped() {
        self.showPlanGenerationAlert {
            
            let faceAreaId = 2
            let isEnabled = self.problemAreas.contains(faceAreaId)
            isEnabled ? self.removeProblemArea(faceAreaId) : self.addProblemArea(faceAreaId)
            self.foreheadViewCheckmark.image = isEnabled ? .FCEmptyCheckbox : .FCCheckedCheckbox
            
        }
    }
    
    @objc func neckViewTapped() {
        self.showPlanGenerationAlert {
            
            let faceAreaId = 3
            let isEnabled = self.problemAreas.contains(faceAreaId)
            isEnabled ? self.removeProblemArea(faceAreaId) : self.addProblemArea(faceAreaId)
            self.neckViewCheckmark.image = isEnabled ? .FCEmptyCheckbox : .FCCheckedCheckbox
            
        }
    }
    
    @objc func chinViewTapped() {
        self.showPlanGenerationAlert {
            
            let faceAreaId = 4
            let isEnabled = self.problemAreas.contains(faceAreaId)
            isEnabled ? self.removeProblemArea(faceAreaId) : self.addProblemArea(faceAreaId)
            self.chinViewCheckmark.image = isEnabled ? .FCEmptyCheckbox : .FCCheckedCheckbox
            
        }
    }
    
    @objc func cheecksViewTapped() {
        self.showPlanGenerationAlert {
            
            let faceAreaId = 5
            let isEnabled = self.problemAreas.contains(faceAreaId)
            isEnabled ? self.removeProblemArea(faceAreaId) : self.addProblemArea(faceAreaId)
            self.cheecksViewCheckmark.image = isEnabled ? .FCEmptyCheckbox : .FCCheckedCheckbox
            
        }
    }
    
    // MARK: - @IBActions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        if State.shared.getProblemAreas() != self.problemAreas {
            State.shared.updateProblemAreas(to: self.problemAreas)
            Training.Daily.getTrainings()
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resetProgressButtonPressed(_ sender: Any) {
        
        self.showConfirmationAlert(message: "Ваш персональный курс будет сгенерировать заново и вы сможете начать сначала", confirmButton: "Сгенерировать") {
        
            // TODO: - Reset current progress
            
            
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
