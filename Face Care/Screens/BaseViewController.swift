import UIKit
import AVFoundation
import Amplitude

class BaseViewController: UIViewController {

    // MARK: - Variables
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
    
    private func showPhotoDeniedAlert() {
        let deniedAlert = UIAlertController(title: "Упс..", message: "Вы запретили программе использовать камеру, но вы можете разрешить использование камеры в настройках", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { UIAlertAction in }
        
        let settingsAction = UIAlertAction(title: "Настройки", style: .default) { UIAlertAction in
            guard let url = URL(string: UIApplication.openSettingsURLString),
                  UIApplication.shared.canOpenURL(url) else {
                assertionFailure("Not able to open App privacy settings")
                return
            }
            
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            return
        }
        
        deniedAlert.addAction(cancelAction)
        deniedAlert.addAction(settingsAction)
        
        present(deniedAlert, animated: true, completion: nil)
    }
    
    private func showPhotoRestrictedAlert() {
        let restrictedAlert = UIAlertController(title: "Упс..", message: "Похоже что доступ к вашей камере ограничен", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ок", style: .cancel) { UIAlertAction in }
        restrictedAlert.addAction(cancelAction)
        present(restrictedAlert, animated: true, completion: nil)
    }
    
    private func setupCaptureSession() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            return
        }
        let CameraViewController = UIImagePickerController()
        CameraViewController.sourceType = .camera
        CameraViewController.cameraDevice = .front
        CameraViewController.delegate = self
        self.present(CameraViewController, animated: true)
    }
    
    func takePhoto() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            DispatchQueue.main.async {
                self.setupCaptureSession()
            }
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    DispatchQueue.main.async {
                        self.setupCaptureSession()
                    }
                }
            }
            
        case .denied:
            self.showPhotoDeniedAlert()
            
        case .restricted:
            self.showPhotoRestrictedAlert()
            return
            
        @unknown default:
            return
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension BaseViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        
        let newImage = ProgressImage(context: context)
        newImage.image = image
        
        do {
            try context.save()
            Amplitude.instance().logEvent(AmplitudeEvent.photoAdded)
        } catch {}
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
