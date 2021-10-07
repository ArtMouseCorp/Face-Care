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
            Training.Daily.getTrainings()
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
    
    // MARK: - @IBActions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        if problemAreas.isEmpty {
            
            let okAction = UIAlertAction(title: "Ok", style: .default)
            let alert = getAlert(title: "Выберите часть лица", message: "Для чтобы сгенерировать курс нужно выбрать хотя бы одну часть лица", actions: okAction)
            self.present(alert, animated: true)
            
            return
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resetProgressButtonPressed(_ sender: Any) {
        
        self.showConfirmationAlert(message: "Ваш персональный курс будет сгенерировать заново и вы сможете начать сначала", confirmButton: "Сгенерировать") {
        
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
        
        let cell = tableView.cellForRow(at: indexPath) as! ProblemAreaTableViewCell
        let faceArea = FaceArea.all[indexPath.row + 1]
        
        if problemAreas.contains(faceArea.id) {
            cell.deselect()
            removeProblemArea(faceArea.id)
        } else {
            cell.select()
            addProblemArea(faceArea.id)
        }
        
        problemAreas.sort()
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
