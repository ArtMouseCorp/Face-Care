import UIKit
import AVFoundation

class ExerciseEndedViewController: BaseViewController {

    // MARK: - @IBOutlets
        
    // Views
    @IBOutlet weak var popupView: UIView!
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var makePhotoButton: FCButton!
    @IBOutlet weak var continueButton: FCButton!
    
    // Image Views
    @IBOutlet weak var mainImage: UIImageView!
    
    // MARK: - Variables

    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        popupView.roundCorners(radius: 32, corners: .topLeft, .topRight)
        makePhotoButton.configure(as: .filled)
        continueButton.configure(as: .filled)
        makePhotoButton.backgroundColor = UIColor(red: 161/255, green: 83/255, blue: 148/255, alpha: 1)
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
    
    // MARK: - @IBActions
    
    @IBAction func makePhotoButtonPressed(_ sender: Any) {
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            self.setupCaptureSession()
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    self.setupCaptureSession()
                }
            }
            
        case .denied:
            super.showPhotoDeniedAlert()
            
        case .restricted:
            super.showPhotoRestrictedAlert()
            return
            
        @unknown default:
            return
        }
        
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ExerciseEndedViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.originalImage] as? UIImage else {
            return
        }

        // print out the image size as a test
        print(image.size)
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
