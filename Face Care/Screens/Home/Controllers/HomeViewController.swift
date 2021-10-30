import UIKit

class HomeViewController: BaseViewController {
    
    // MARK: - @IBOutlets
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var exclusiveTrainingsTitleLabel: UILabel!
    @IBOutlet weak var exercisesTitleLabel: UILabel!
    @IBOutlet var facePartsLabels: [UILabel]!
    
    // Buttons
    @IBOutlet weak var menuButton: UIButton!
    
    // Collection Views
    @IBOutlet weak var dailyTrainingsCollectionView: UICollectionView!
    @IBOutlet weak var exclusiveTrainingsCollectionView: UICollectionView!
    
    // Table Views
    @IBOutlet var exercisesTableViews: [UITableView]!
    
    // Constraints
    @IBOutlet var exercisesTableViewHeightConstraints: [NSLayoutConstraint]!
    
    // Page Control
    @IBOutlet weak var dots: UIPageControl!
    
    // MARK: - Variables
    
    var isSubviewed = false
    let cellWidth: CGFloat = UIScreen.main.bounds.width - 42
    let cellHeight: CGFloat = 436
    var sectionCount: Int = 2
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.configure(dailyTrainingsCollectionView, with: .dailyTraining)
        super.configure(exclusiveTrainingsCollectionView, with: .exclusiveTraining)
        
        for exercisesTableView in exercisesTableViews {
            self.configure(exercisesTableView, with: .exercise)
        }
        
        State.shared.tabBarController = self.tabBarController! as! TabBarController
    }
    
    override func viewDidLayoutSubviews() {
        guard !isSubviewed else { return }
        configureCollectionViews()
        configureTableViews()
        isSubviewed = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        localize()
        configureUI()
        State.shared.setCurrentScreen(to: "Home Screen")
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
    }
    
    private func localize() {
        titleLabel.localize(with: L.Home.title)
        exclusiveTrainingsTitleLabel.localize(with: L.Home.exclusiveTrainings)
        exercisesTitleLabel.localize(with: L.Home.exercisesList)
        dailyTrainingsCollectionView.reloadData()
        exclusiveTrainingsCollectionView.reloadData()
        
        facePartsLabels[0].localize(with: L.FacePart.lymph)
        facePartsLabels[1].localize(with: L.FacePart.eyes)
        facePartsLabels[2].localize(with: L.FacePart.forehead)
        facePartsLabels[3].localize(with: L.FacePart.neck)
        facePartsLabels[4].localize(with: L.FacePart.chin)
        facePartsLabels[5].localize(with: L.FacePart.cheekbonesAndCheeks)
        
        for exercisesTableView in exercisesTableViews {
            exercisesTableView.reloadData()
        }
    }
    
    private func configureCollectionViews() {
        
        dailyTrainingsCollectionView.backgroundColor = .clear
        dailyTrainingsCollectionView.layer.masksToBounds = false
        
        let layout = PagingCollectionViewLayout()
        
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 16)
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.minimumLineSpacing = 8
        layout.velocityThresholdPerPage = 5
        
        dailyTrainingsCollectionView.decelerationRate = .fast
        dailyTrainingsCollectionView.collectionViewLayout = layout
        
        exclusiveTrainingsCollectionView.backgroundColor = .clear
        exclusiveTrainingsCollectionView.layer.masksToBounds = false
    }
    
    private func configureTableViews() {
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            for i in 0 ..< self.exercisesTableViews.count {
                
                self.exercisesTableViews[i].layer.masksToBounds = false
                self.exercisesTableViewHeightConstraints[i].constant = self.exercisesTableViews[i].contentHeight
                self.exercisesTableViewHeightConstraints[i].constant = self.exercisesTableViews[i].contentHeight
                
            }
        }
        
    }
    
    // MARK: - @IBActions
    
    @IBAction func menuButtonPressed(_ sender: Any) {
        let settingsViewController = SettingsViewController.load(from: Screen.settings)
        self.navigationController?.pushViewController(settingsViewController, animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let index = exercisesTableViews.firstIndex(of: tableView) else { return 0 }
        return FaceArea.all[index].exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.exercise.id, for: indexPath) as! ExerciseTableViewCell
            
        guard let index = exercisesTableViews.firstIndex(of: tableView) else { return UITableViewCell() }
        let exercise = FaceArea.all[index].exercises[indexPath.row]
            
        cell.configure(name: exercise.name, description: exercise.description, image: exercise.getImage())
        self.configureTableViews()
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        StoreManager.updateStatus()
        guard State.shared.isSubscribed else {
            let photoOfferVC = PhotoOfferViewController.load(from: Screen.photoOffer)
            photoOfferVC.modalPresentationStyle = .fullScreen
            photoOfferVC.page = 3
            photoOfferVC.isToggleOn = true
            photoOfferVC.paywallSource = .home
            self.present(photoOfferVC, animated: true)
            return
        }
        
        let exerciseVC = ExerciseViewController.load(from: Screen.exercise)
        exerciseVC.modalPresentationStyle = .fullScreen
        guard let index = exercisesTableViews.firstIndex(of: tableView) else { return }
        exerciseVC.exercises = [FaceArea.all[index].exercises[indexPath.row]]
        self.present(exerciseVC, animated: true)
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
            
        case dailyTrainingsCollectionView:
            dots.numberOfPages = Training.Daily.trainings.count
            return Training.Daily.trainings.count
        case exclusiveTrainingsCollectionView:
            return Training.Exclusive.trainings.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
            
        case dailyTrainingsCollectionView:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.dailyTraining.id, for: indexPath) as! DailyTrainingCollectionViewCell
            
            let dailyTraining = Training.Daily.trainings[indexPath.row]
            
            cell.configure(with: dailyTraining)
            
            return cell
            
        case exclusiveTrainingsCollectionView:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.exclusiveTraining.id, for: indexPath) as! ExclusiveTrainingCollectionViewCell
            
            let exclusiveTraining = Training.Exclusive.trainings[indexPath.row]
            cell.configure(with: exclusiveTraining)
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                
        StoreManager.updateStatus()
        guard State.shared.isSubscribed else {
            let photoOfferVC = PhotoOfferViewController.load(from: Screen.photoOffer)
            photoOfferVC.modalPresentationStyle = .fullScreen
            photoOfferVC.page = 3
            photoOfferVC.isToggleOn = true
            photoOfferVC.paywallSource = .home
            self.present(photoOfferVC, animated: true)
            return
        }

        switch collectionView {
            
        case dailyTrainingsCollectionView:
            
            let dailyTraining = Training.Daily.trainings[indexPath.row]
            
            guard dailyTraining.isOpen() else {
                
                let title = L.get(key: L.Alert.DailyTrainingLocked.title)
                let message = L.get(key: L.Alert.DailyTrainingLocked.message, args: dailyTraining.dayNumber, dailyTraining.dayNumber - 1)

                let okAction = UIAlertAction(title: L.get(key: L.Alert.Action.ok), style: .default)
                let alert = getAlert(title: title, message: message, actions: okAction)
                self.present(alert, animated: true)
                
                return
                
            }
            
            let exerciseVC = ExerciseViewController.load(from: Screen.exercise)
            
            exerciseVC.exercises = dailyTraining.training.exercises
            exerciseVC.trainingNumber = dailyTraining.dayNumber
            exerciseVC.modalPresentationStyle = .fullScreen
            exerciseVC.modalTransitionStyle = .crossDissolve
            
            self.present(exerciseVC, animated: true) {
                self.navigationController?.popViewController(animated: false)
            }
            
        case exclusiveTrainingsCollectionView:
            
            let exclusiveTraining = Training.Exclusive.trainings[indexPath.row]
            
            let exerciseVC = ExerciseViewController.load(from: Screen.exercise)

            exerciseVC.exercises = exclusiveTraining.exercises
            exerciseVC.modalPresentationStyle = .fullScreen
            exerciseVC.modalTransitionStyle = .crossDissolve
            
            self.present(exerciseVC, animated: true) {
                self.navigationController?.popViewController(animated: false)
            }
            
        default:
            break
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        switch collectionView {
            
        case dailyTrainingsCollectionView:
            return 8
        case exclusiveTrainingsCollectionView:
            return 16
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
            
        case dailyTrainingsCollectionView:
            return 8
        case exclusiveTrainingsCollectionView:
            return 16
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        switch collectionView {
            
        case dailyTrainingsCollectionView:
            return UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 24)
        case exclusiveTrainingsCollectionView:
            return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        default:
            return UIEdgeInsets()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        switch collectionView {
        case dailyTrainingsCollectionView:
            return CGSize(width: cellWidth, height: cellHeight)
        case exclusiveTrainingsCollectionView:
            return CGSize(width: 152, height: 244)
        default:
            return .zero
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        dots.currentPage = Int(((dailyTrainingsCollectionView.contentOffset.x + 40) / dailyTrainingsCollectionView.frame.width).rounded(.toNearestOrAwayFromZero))
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
