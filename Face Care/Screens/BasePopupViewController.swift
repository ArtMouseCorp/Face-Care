import UIKit
import PanModal

class BasePopupViewController: UIViewController, PanModalPresentable {

    // MARK: - Variables
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var panScrollable: UIScrollView? = nil
    var cornerRadius: CGFloat = 20
    var showDragIndicator: Bool = false
    var anchorModalToLongForm: Bool = false
    
    var longFormHeight: PanModalHeight = .contentHeight(0)
    var shortFormHeight: PanModalHeight = .contentHeight(0)
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    // MARK: - Custom functions
    
    func setPopupHeight(short shortForm: CGFloat, long longForm: CGFloat) {
        shortFormHeight = .contentHeight(shortForm + safeAreaBottomInset)
        longFormHeight = .contentHeight(longForm + safeAreaBottomInset)
    }
    
    func setPopupHeight(_ height: CGFloat) {
        setPopupHeight(short: height, long: height)
    }
    
    func setPanScrollable(to scrollView: UIScrollView?) {
        self.panScrollable = scrollView
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
