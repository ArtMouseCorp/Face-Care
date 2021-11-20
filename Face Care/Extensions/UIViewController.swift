import UIKit
import PanModal

extension UIViewController {
    
    public static func load(from screen: StoryboardScreen) -> Self {
        return screen.storyboard.instantiateViewController(withIdentifier: screen.id) as! Self
    }
    
    public func showNetworkConnectionAlert(completion: (() -> ())? = nil) {
        let alertOk = UIAlertAction(title: L.get(key: L.Alert.Action.ok), style: .default) { _ in
            completion?() ?? ()
        }
        self.present(getAlert(title: L.get(key: L.Alert.Connection.title),
                              message: L.get(key: L.Alert.Connection.message),
                              actions: alertOk),
                     animated: true,
                     completion: nil
        )
    }
    
    public func showAlreadySubscribedAlert(completion: (() -> ())? = nil) {
        let alertOk = UIAlertAction(title: L.get(key: L.Alert.Action.ok), style: .default) { _ in
            completion?() ?? ()
        }
        self.present(getAlert(title: L.get(key: L.Alert.Subscribed.title),
                              message: L.get(key: L.Alert.Subscribed.message),
                              actions: alertOk),
                     animated: true,
                     completion: nil
        )
    }
    
    public func showNotSubscriberAlert(completion: (() -> ())? = nil) {
        let alertOk = UIAlertAction(title: L.get(key: L.Alert.Action.ok), style: .default) { _ in
            completion?() ?? ()
        }
        self.present(getAlert(title: L.get(key: L.Alert.NotSubscriber.title),
                              message: L.get(key: L.Alert.NotSubscriber.message),
                              actions: alertOk),
                     animated: true,
                     completion: nil
        )
    }
    
    public func showRestoredAlert(completion: (() -> ())? = nil) {
        let alertOk = UIAlertAction(title: L.get(key: L.Alert.Action.ok), style: .default) { _ in
            completion?() ?? ()
        }
        self.present(getAlert(title: L.get(key: L.Alert.Restored.title),
                              message: L.get(key: L.Alert.Restored.message),
                              actions: alertOk),
                     animated: true,
                     completion: nil
        )
    }
    
    public func showPopup(_ popup: UIViewController) {
        self.addChild(popup)
        popup.view.frame = self.view.frame
        UIView.transition(with: self.view, duration: 0.25, options: [.transitionCrossDissolve], animations: {
            self.view.addSubview(popup.view)
        }, completion: nil)
        popup.didMove(toParent: self)
    }
    
    public func presentPanModaliPad(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        if let presentableController = viewControllerToPresent as? PanModalPresentable, let controller = presentableController as? UIViewController {
            controller.modalPresentationStyle = .custom
            controller.modalPresentationCapturesStatusBarAppearance = true
            controller.transitioningDelegate = PanModalPresentationDelegate.default
            self.present(controller, animated: flag, completion: completion)
            return
        }
        self.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    func showLoader() {
        let alert = UIAlertController(title: nil, message: L.get(key: L.Alert.Loading.message), preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func hideLoader(completion: (() -> Void)? = nil) {
        dismiss(animated: false, completion: completion)
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
