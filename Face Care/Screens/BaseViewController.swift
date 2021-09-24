import UIKit

class BaseViewController: UIViewController {

    // MARK: - Variables
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Custom functions
    
    func showTabBar(_ show: Bool = true) {
        self.tabBarController?.tabBar.isHidden = !show
    }
    
    func hideTabBar() {
        showTabBar(false)
    }
    
    func configure(_ tableView: UITableView, with cells: Cell...) {
        tableView.delegate = self as? UITableViewDelegate
        tableView.dataSource = self as? UITableViewDataSource
        for cell in cells {
            tableView.registerCell(cell: cell)
        }
    }
    
    func configure(_ collectionView: UICollectionView, with cells: Cell...) {
        collectionView.delegate = self as? UICollectionViewDelegate
        collectionView.dataSource = self as? UICollectionViewDataSource
        for cell in cells {
            collectionView.registerCell(cell: cell)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
