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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            for i in 0 ..< self.exercisesTableViews.count {
                
                self.exercisesTableViews[i].layer.masksToBounds = false
                self.exercisesTableViewHeightConstraints[i].constant = self.exercisesTableViews[i].contentHeight
                self.exercisesTableViewHeightConstraints[i].constant = self.exercisesTableViews[i].contentHeight
                
            }
        }
        
    }
    
//    private func setupDotImages() {
//        let dotImages = ["dot1", "dot2", "dot3", "dot1", "dot2"]
//
//        let offset = self.exercisesTableView.contentHeight / CGFloat(dotImages.count)
//
//        for i in 0 ..< dotImages.count {
//
//            let imageView = UIImageView()
//
//            var x: CGFloat = 0
//            let y: CGFloat = offset * CGFloat(i)
//
//            switch i {
//            case 0:
//                x = -71
//                imageView.image = UIImage(named: "dot1")
//            case 1:
//                x = 225
//                imageView.image = UIImage(named: "dot2")
//            case 2:
//                x = -29
//                imageView.image = UIImage(named: "dot3")
//            case 3:
//                x = 216
//                imageView.image = UIImage(named: "dot1")
//            case 4:
//                x = 225
//                imageView.image = UIImage(named: "dot2")
//            default: break
//            }
//
//            imageView.frame = CGRect(x: x, y: y, width: 222, height: 222)
//            self.exercisesTableView.insertSubview(imageView, at: 0)
//
//        }
//    }
    
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
            
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let exerciseLoading = ExerciseLoadingViewController.load(from: Screen.exerciseLoading)
        exerciseLoading.modalPresentationStyle = .fullScreen
        guard let index = exercisesTableViews.firstIndex(of: tableView) else { return }
        exerciseLoading.exercisePack = [FaceArea.all[index].exercises[indexPath.row]]
        self.present(exerciseLoading, animated: true)
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
            return 6
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
            cell.alpha = State.shared.getOpenedDailyTrainings()[indexPath.row] ? 1 : 0.6
            
            return cell
            
        case exclusiveTrainingsCollectionView:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.exclusiveTraining.id, for: indexPath) as! ExclusiveTrainingCollectionViewCell
            
            //            cell.configure(name: <#T##String#>, duration: <#T##String#>, image: <#T##UIImage#>)
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView {
            
        case dailyTrainingsCollectionView:
            
            let dailyTraining = Training.Daily.trainings[indexPath.row]
            
            guard State.shared.getOpenedDailyTrainings()[indexPath.row] else { return }
            
            let trainingVC = TrainingViewController.load(from: Screen.training)
            trainingVC.training = dailyTraining.training
            trainingVC.endExerciseCompletion = {
                let endExerciseVC = TrainingCompletedViewController.load(from: Screen.trainingEnded)
                endExerciseVC.trainingNumber = dailyTraining.dayNumber
                self.navigationController?.pushViewController(endExerciseVC, animated: true)
            }
            self.navigationController?.pushViewController(trainingVC, animated: true)
            self.navigationController?.hidesBottomBarWhenPushed = true
            
        case exclusiveTrainingsCollectionView:
            
            let trainingVC = TrainingViewController.load(from: Screen.training)
            trainingVC.modalPresentationStyle = .fullScreen
            self.present(trainingVC, animated: true)
            
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
