import UIKit

extension UIViewController {
    
    public static func load(from screen: StoryboardScreen) -> Self {
        return screen.storyboard.instantiateViewController(withIdentifier: screen.id) as! Self
    }
    
    public func showNetworkConnectionAlert(completion: (() -> ())? = nil) {
        let alertOk = UIAlertAction(title: L.Alert.Action.ok, style: .default) { _ in
            completion?() ?? ()
        }
        self.present(getAlert(title: L.Alert.Connection.title,
                              message: L.Alert.Connection.message,
                              actions: alertOk),
                     animated: true,
                     completion: nil
        )
    }
    
    public func showAlreadySubscribedAlert(completion: (() -> ())? = nil) {
        let alertOk = UIAlertAction(title: L.Alert.Action.ok, style: .default) { _ in
            completion?() ?? ()
        }
        self.present(getAlert(title: L.Alert.Subscribed.title,
                              message: L.Alert.Subscribed.message,
                              actions: alertOk),
                     animated: true,
                     completion: nil
        )
    }
    
    public func showNotSubscriberAlert(completion: (() -> ())? = nil) {
        let alertOk = UIAlertAction(title: L.Alert.Action.ok, style: .default) { _ in
            completion?() ?? ()
        }
        self.present(getAlert(title: L.Alert.NotSubscriber.title,
                              message: L.Alert.NotSubscriber.message,
                              actions: alertOk),
                     animated: true,
                     completion: nil
        )
    }
    
    public func showRestoredAlert(completion: (() -> ())? = nil) {
        let alertOk = UIAlertAction(title: L.Alert.Action.ok, style: .default) { _ in
            completion?() ?? ()
        }
        self.present(getAlert(title: L.Alert.Restored.title,
                              message: L.Alert.Restored.message,
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
