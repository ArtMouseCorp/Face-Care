import UIKit
import CoreData

class ProgressViewController: BaseViewController {

    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var corneredView: UIView!
    
    // Labels
    @IBOutlet weak var userProgressMainLabel: UILabel!
    @IBOutlet weak var userProgressMainDescription: UILabel!
    @IBOutlet weak var progressGalleryLabel: UILabel!
    @IBOutlet weak var everydayPointLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var watchDemonstrationButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    // Colelction Views
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Table Views
    @IBOutlet weak var tableView: UITableView!
    
    // Constraints
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Variables
    
    var collectionViewData: [ProgressImage]?
    
    let collectionViewFakeData = [
        "FC Add Photo", "progress-demo-1", "progress-demo-2", "progress-demo-1", "progress-demo-2"
    ]
    
    
    
    let tableViewData = [
        [
            "title": "Глаза",
            "stat": 1
        ],
        [
            "title": "Лоб",
            "stat": 3
        ],
        [
            "title": "Шея",
            "stat": 6
        ],
        [
            "title": "Подбородок",
            "stat": 7
        ],
        [
            "title": "Скулы и щеки",
            "stat": 0
        ]
    ]
    
    let screenWidth = UIScreen.main.bounds.width
    var tableViewHeight: CGFloat {
        tableView.layoutIfNeeded()
        return tableView.contentSize.height
    }
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(collectionView, with: .progressImages)
        configure(tableView, with: .progressStat)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
        fetchImages()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        mainView.roundCorners(radius: 32, corners: .topLeft, .topRight)
        corneredView.roundCorners(radius: 32, corners: .topLeft, .topRight)
        tableViewHeightConstraint.constant = tableViewHeight
    }
    
    func fetchImages() {
        do {
            self.collectionViewData = try super.context.fetch(ProgressImage.fetchRequest())
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        catch { }
    }
    
    // MARK: - @IBActions
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        let settingsViewController = ProgressSettingsViewController.load(from: Screen.progressSettings)
        self.navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    @IBAction func watchDemonstrationButtonPressed(_ sender: Any) {
        
    }
    
}

// MARK: - Collection View Extension

extension ProgressViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.collectionViewData?.count ?? 0) + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.progressImages.id, for: indexPath) as! ProgressCollectionViewCell
        if indexPath.row == 0 {
            cell.mainImageView.image = UIImage(named: "FC Add Photo")
        } else {
            cell.mainImageView.image = self.collectionViewData?[indexPath.row - 1].image
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 116)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            super.takePhoto()
        } else {
            self.tabBarController?.tabBar.isHidden = true
            let cell = collectionView.cellForItem(at: indexPath) as! ProgressCollectionViewCell
            
            let popup = ImagePopup.load(from: Popup.image)
            popup.mainImage = cell.mainImageView.image
            self.addChild(popup)
            popup.view.frame = self.view.frame
            popup.onPopupClose = {
                self.tabBarController?.tabBar.isHidden = false
            }
            UIView.transition(with: self.view, duration: 0.25, options: [.transitionCrossDissolve], animations: {
                self.view.addSubview(popup.view)
            }, completion: nil)
        }
    }
    
}

// MARK: - Table View extensions

extension ProgressViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.progressStat.id, for: indexPath) as! ProgressTableViewCell
        
        let data = tableViewData[indexPath.row]
        let stat = data["stat"] as! Int
        
        cell.titleLabel.text = data["title"] as? String
        cell.statLabel.text = "\(stat)/7"
        
        if stat < 2 {
            cell.insideProgressView.backgroundColor = UIColor.FCHalloweenOrange
        }
        else if stat < 4 {
            cell.insideProgressView.backgroundColor = UIColor.FCMarigold
        }
        else if stat < 7 {
            cell.insideProgressView.backgroundColor = UIColor.FCKiwi
        }
        else {
            cell.insideProgressView.backgroundColor = UIColor.FCLimeGreen
        }

        cell.progressWidthConstraint.constant = ((screenWidth-32) * CGFloat(stat)) / 7
        
        return cell
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
