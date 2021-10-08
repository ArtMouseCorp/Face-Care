import UIKit

class TabBarController: UITabBarController {

    // MARK: - Variables
    
    open override var shouldAutorotate: Bool {
        get {
            return false
        }
    }
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        localize()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        
        tabBar.layer.shadowColor = UIColor.FCBlack.withAlphaComponent(0.08).cgColor
        tabBar.layer.shadowOpacity = 0.5
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -1)
        tabBar.layer.shadowRadius = 3
        self.tabBar.layer.borderColor = UIColor.clear.cgColor
        self.tabBar.layer.borderWidth = 0
        self.tabBar.clipsToBounds = false
        self.tabBar.backgroundColor = UIColor.white
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        
    }
    
    private func localize() {
        tabBar.items?[0].title = "Main"
        tabBar.items?[1].title = "Progress"
        tabBar.items?[2].title = "Articles"
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
