import UIKit

class HomeViewController: BaseViewController {

    // MARK: - @IBOutlets
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var exclusiveTrainingsTitleLabel: UILabel!
    @IBOutlet weak var exercisesTitleLabel: UILabel!
    @IBOutlet weak var eyesExercisesTitleLabel: UILabel!
    @IBOutlet weak var foreheadExercisesTitleLabel: UILabel!
    @IBOutlet weak var neckExercisesTitleLabel: UILabel!
    @IBOutlet weak var chinExercisesTitleLabel: UILabel!
    @IBOutlet weak var cheeksExercisesTitleLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var menuButton: UIButton!
    
    // Collection Views
    @IBOutlet weak var dailyTrainingsCollectionView: UICollectionView!
    @IBOutlet weak var exclusiveTrainingsCollectionView: UICollectionView!
    
    // Table Views
    @IBOutlet weak var eyesExercisesTableView: UITableView!
    @IBOutlet weak var foreheadExercisesTableView: UITableView!
    @IBOutlet weak var neckExercisesTableView: UITableView!
    @IBOutlet weak var chinExercisesTableView: UITableView!
    @IBOutlet weak var cheeksExercisesTableView: UITableView!
    
    // Constraints
    @IBOutlet weak var eyesExercisesTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var foreheadExercisesTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var neckExercisesTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var chinExercisesTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var cheeksExercisesTableViewHeightConstraint: NSLayoutConstraint!
    
    // Page Control
    @IBOutlet weak var dots: UIPageControl!
    
    // MARK: - Variables
    
    var eyesExercisesTableViewHeight: CGFloat {
        eyesExercisesTableView.layoutIfNeeded()
        return eyesExercisesTableView.contentSize.height
    }
    
    var foreheadExercisesTableViewHeight: CGFloat {
        foreheadExercisesTableView.layoutIfNeeded()
        return foreheadExercisesTableView.contentSize.height
    }
    
    var neckExercisesTableViewHeight: CGFloat {
        neckExercisesTableView.layoutIfNeeded()
        return neckExercisesTableView.contentSize.height
    }
    
    var chinExercisesTableViewHeight: CGFloat {
        chinExercisesTableView.layoutIfNeeded()
        return chinExercisesTableView.contentSize.height
    }
    
    var cheeksExercisesTableViewHeight: CGFloat {
        cheeksExercisesTableView.layoutIfNeeded()
        return cheeksExercisesTableView.contentSize.height
    }
    
    var isSubviewed = false
    let cellWidth: CGFloat = UIScreen.main.bounds.width - 42
    let cellHeight: CGFloat = 436
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.configure(dailyTrainingsCollectionView, with: .dailyTraining)
        super.configure(exclusiveTrainingsCollectionView, with: .exclusiveTraining)
        super.configure(eyesExercisesTableView, with: .exercise)
        super.configure(foreheadExercisesTableView, with: .exercise)
        super.configure(neckExercisesTableView, with: .exercise)
        super.configure(chinExercisesTableView, with: .exercise)
        super.configure(cheeksExercisesTableView, with: .exercise)
        State.tabBarController = self.tabBarController! as! TabBarController
    }
    
    override func viewDidLayoutSubviews() {
        if !isSubviewed {
            configureCollectionViews()
            configureTableViews()
            configureTableViews()
          isSubviewed = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
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
        
        eyesExercisesTableView.layer.masksToBounds = false
        foreheadExercisesTableView.layer.masksToBounds = false
        neckExercisesTableView.layer.masksToBounds = false
        chinExercisesTableView.layer.masksToBounds = false
        cheeksExercisesTableView.layer.masksToBounds = false
        
        eyesExercisesTableViewHeightConstraint.constant = eyesExercisesTableViewHeight
        foreheadExercisesTableViewHeightConstraint.constant = foreheadExercisesTableViewHeight
        neckExercisesTableViewHeightConstraint.constant = neckExercisesTableViewHeight
        chinExercisesTableViewHeightConstraint.constant = chinExercisesTableViewHeight
        cheeksExercisesTableViewHeightConstraint.constant = cheeksExercisesTableViewHeight
        
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
        
        switch tableView {
            
        case eyesExercisesTableView:
            return 3
        case foreheadExercisesTableView:
            return 3
        case neckExercisesTableView:
            return 3
        case chinExercisesTableView:
            return 3
        case cheeksExercisesTableView:
            return 3
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.exercise.id, for: indexPath) as! ExerciseTableViewCell
        
        switch tableView {
            
        case eyesExercisesTableView: ()
        case foreheadExercisesTableView: ()
        case neckExercisesTableView: ()
        case chinExercisesTableView: ()
        case cheeksExercisesTableView: ()
        default: ()
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let trainingVC = TrainingViewController.load(from: Screen.training)
//        trainingVC.modalPresentationStyle = .fullScreen
//        self.present(trainingVC, animated: true)
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
            
        case dailyTrainingsCollectionView:
            dots.numberOfPages = 7
            return 7
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
            
//            cell.configure(name: <#T##String#>, day: <#T##String#>, duration: <#T##String#>, image: <#T##UIImage#>)
            
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
            
            let trainingVC = TrainingViewController.load(from: Screen.training)
//            trainingVC.modalPresentationStyle = .fullScreen
//            self.present(trainingVC, animated: true)
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
