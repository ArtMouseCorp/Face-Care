import UIKit
import AVFoundation

class ExerciseViewController: BaseViewController {

    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var videoView: UIView!
    
    // Labels
    @IBOutlet weak var exerciseNameLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var closeButton: UIButton!
    
    // Image Views
    @IBOutlet weak var mainImageView: UIImageView!
    
    // Stack views
    @IBOutlet weak var linesStackView: UIStackView!
    
    // Slider
    @IBOutlet weak var slider: UISlider!
    
    // MARK: - Variables
    
    var onDismiss: ((_ currentItem: Int, _ isClose: Bool, _ isEnded: Bool) -> ()) = {_,_,_ in }
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer!
    var isPlaying = true
    var exercisePack: [Exercise] = []
    var currentItem = 0
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
        exerciseNameLabel.text = "Упражнение \(currentItem + 1):\n\(exercisePack[currentItem].name)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
        setupGestures()
        configurePlayer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        player!.play()
        addTimeObserver()
    }
    
    override func viewDidLayoutSubviews() {
        playerLayer.frame = videoView.bounds
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        self.slider.setThumbImage(UIImage(named: "FC Slider Thumb")!, for: .normal)
        self.slider.setThumbImage(UIImage(named: "FC Slider Thumb")!, for: .highlighted)
        
        var counter = 0
        for view in linesStackView.subviews {
            view.backgroundColor = counter <= currentItem ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
            if counter >= exercisePack.count {
                view.isHidden = true
            }
            view.capsuleCorners()
            counter += 1
        }
    }
    
    private func configurePlayer() {
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        videoView.layer.addSublayer(playerLayer)
    }
    
    private func configureOnPopup(isHidden: Bool = true) {
        linesStackView.isHidden = !isHidden
        closeButton.isHidden = !isHidden
        exerciseNameLabel.isHidden = !isHidden
    }
    
    private func setupGestures() {
        videoView.addTapGesture(target: self, action: #selector(pauseVideo))
    }
    
    func addTimeObserver() {
        let interval = CMTime(seconds: 0.01, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        let mainQueue = DispatchQueue.main
        _ = player?.addPeriodicTimeObserver(forInterval: interval, queue: mainQueue, using: { time in
            guard let currentItem = self.player?.currentItem else {return}
            self.slider.minimumValue = 0
            self.slider.maximumValue = Float(currentItem.duration.seconds)
            self.slider.value = Float(currentItem.currentTime().seconds)
            
        })
    }
    
    // MARK: - Gesture actions
    
    @objc private func pauseVideo() {
        player!.pause()
        let infoPopup = ExerciseInfoPopup.load(from: Popup.exerciseInfo)
        infoPopup.currentItem = self.currentItem
        infoPopup.exercisePack = self.exercisePack
        infoPopup.onCloseCompletion = { index in
            if self.currentItem == index {
                self.player?.play()
            } else {
                self.player?.pause()
                self.dismiss(animated: false) {
                    self.onDismiss(index, false, false)
                }
            }
        }
        self.presentPanModal(infoPopup)
    }
    
    @objc func playerDidFinishPlaying() {
        isPlaying = false
        let index = currentItem + 1
        
        if index > exercisePack.count - 1 {
            self.dismiss(animated: false) {
                self.onDismiss(index, false, true)
            }
        }
        else {
            self.dismiss(animated: false) {
                self.onDismiss(index, false, false)
            }
        }
    }
    
    // MARK: - @IBActions
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        
        self.player?.pause()
        
        let alert = UIAlertController(title: "Вы уверены, что хотите выйти?", message: nil, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Да", style: .default) { _ in
            self.dismiss(animated: true) {
                self.onDismiss(self.currentItem, true, false)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel) { _ in
            self.player?.play()
        }
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider, event: UIEvent) {
        
        player?.seek(to: CMTimeMake(value: Int64(sender.value * 1000), timescale: 1000))
        
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                player?.pause()
            case .moved:
                player?.pause()
            case .ended:
                player?.play()
            default:
                break
            }
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
