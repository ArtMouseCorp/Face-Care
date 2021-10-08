import UIKit

class ProgressSettingsViewController: BaseViewController {
    
    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var mainView: UIView!
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var problemAreasTitleLabel: UILabel!
    @IBOutlet weak var resetProgressLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var resetProgressButton: FCButton!
    
    // TableViews
    @IBOutlet weak var problemAreasTableView: UITableView!
    
    // Constraints
    @IBOutlet weak var problemAreasTableViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Variables
    
    let defaults = UserDefaults.standard
    
    var problemAreas = State.shared.getProblemAreas()
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.configure(problemAreasTableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        problemAreas = State.shared.getProblemAreas()
        localize()
        configureUI()
        State.shared.setCurrentScreen(to: "Progress Settings Screen")
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        guard !self.problemAreas.isEmpty else { return }
        
        if !State.shared.getProblemAreas().containsSameElements(as: problemAreas) {
            
            State.shared.updateProblemAreas(to: self.problemAreas)
            Training.Daily.createTrainings()
            State.shared.clearCompletedDailyTrainings()
            print("Trainings updated")
            
        }
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        mainView.roundCorners(radius: 32, corners: .topLeft, .topRight)
        resetProgressButton.configure(as: .filled)
        
        problemAreasTableViewHeightConstraint.constant = problemAreasTableView.contentHeight
    }
    
    private func localize() {
        titleLabel.localize(with: L.Progress.Settings.title)
        problemAreasTitleLabel.localize(with: L.Progress.Settings.problemAreas)
        resetProgressLabel.localize(with: L.Progress.Settings.resetDescription)
        resetProgressButton.localize(with: L.Progress.Settings.ProgressButton.resetProgress)
    }

    private func showPlanGenerationAlert(completion: @escaping (() -> ())) {
        
        let generateAction = UIAlertAction(title: L.get(key: L.Alert.Action.generate), style: .default) { _ in
            completion()
        }
        
        let cancelAction = UIAlertAction(title: L.get(key: L.Alert.Action.cancel), style: .cancel)
        
        let alert = getAlert(title: L.get(key: L.Alert.ResetProgressSure.title), message: L.get(key: L.Alert.ResetProgressSure.message), actions: generateAction, cancelAction)
        
        self.present(alert, animated: true)
    }
    
    private func addProblemArea(_ element: Int) {
        self.problemAreas.append(element)
    }
    
    private func removeProblemArea(_ element: Int) {
        if let index = self.problemAreas.firstIndex(of: element) {
            self.problemAreas.remove(at: index)
        }
    }
    
    // MARK: - @IBActions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        if problemAreas.isEmpty {
            
            let okAction = UIAlertAction(title: L.get(key: L.Alert.Action.ok), style: .default)
            let alert = getAlert(title: L.get(key: L.Alert.ProblemArea.title), message: L.get(key: L.Alert.ProblemArea.message), actions: okAction)
            self.present(alert, animated: true)
            
            return
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resetProgressButtonPressed(_ sender: Any) {
        
        self.showPlanGenerationAlert() {
        
            self.problemAreas.removeAll()
            self.problemAreasTableView.reloadData()
            
        }
        
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ProgressSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FaceArea.all.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.problemArea.id, for: indexPath) as! ProblemAreaTableViewCell
        
        let faceArea = FaceArea.all[indexPath.row + 1]
        
        cell.configure(name: faceArea.name, isChecked: problemAreas.contains(faceArea.id))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        showPlanGenerationAlert() {
            
            let cell = tableView.cellForRow(at: indexPath) as! ProblemAreaTableViewCell
            let faceArea = FaceArea.all[indexPath.row + 1]
            
            if self.problemAreas.contains(faceArea.id) {
                cell.deselect()
                self.removeProblemArea(faceArea.id)
            } else {
                cell.select()
                self.addProblemArea(faceArea.id)
            }
            
            self.problemAreas.sort()
            
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
