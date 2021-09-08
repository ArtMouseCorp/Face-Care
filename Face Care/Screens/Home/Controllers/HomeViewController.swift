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
    @IBOutlet weak var exercisesTableViewView: UITableView!
    
    // MARK: - Variables
    
    var isSubviewed = false
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.configure(dailyTrainingsCollectionView, with: .dailyTraining)
        super.configure(exclusiveTrainingsCollectionView, with: .exclusiveTraining)
//        super.configure(exercisesTableViewView, with: .exercise)
    }
    
    override func viewDidLayoutSubviews() {
        if !isSubviewed {
            configureCollectionViews()
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
        
        let cellWidth: CGFloat = UIScreen.main.bounds.width - 42
        let cellHeight: CGFloat = 436
        
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 16)
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.minimumLineSpacing = 30
        layout.velocityThresholdPerPage = 5
        
        print("\n\n\n", layout, "\n\n\n")
        
        dailyTrainingsCollectionView.decelerationRate = .fast
        dailyTrainingsCollectionView.collectionViewLayout = layout
        
        print("\n\n\n", dailyTrainingsCollectionView.collectionViewLayout, "\n\n\n")
        
        exclusiveTrainingsCollectionView.backgroundColor = .clear
        exclusiveTrainingsCollectionView.layer.masksToBounds = false
    }
    
    // MARK: - @IBActions
    
    @IBAction func menuButtonPressed(_ sender: Any) {
        // TODO: - Go to menu
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
            
        case dailyTrainingsCollectionView:
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
            
            () // TODO: - Open daily training
            
        case exclusiveTrainingsCollectionView:
            
            () // TODO: - Open exclusive training
        
        default:
            break
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        switch collectionView {
            
//        case dailyTrainingsCollectionView:
//            return 8
        case exclusiveTrainingsCollectionView:
            return 16
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        switch collectionView {

//        case dailyTrainingsCollectionView:
//            return UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 16)
        case exclusiveTrainingsCollectionView:
            return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        default:
            return UIEdgeInsets()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
            
        case exclusiveTrainingsCollectionView:
            return CGSize(width: 152, height: 244)
        default:
            return .zero
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
