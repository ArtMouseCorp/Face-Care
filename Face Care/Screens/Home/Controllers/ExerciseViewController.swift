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
    
    var player: AVPlayer = AVPlayer()
    var playerLayer: AVPlayerLayer!
    
    var exercises: [Exercise] = []
    var trainingNumber: Int?
    var currentItem = 0
    
    let loader = ExerciseLoadingViewController.load(from: Screen.exerciseLoading)
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadVideo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateView()
        setupGestures()
        State.shared.setCurrentScreen(to: "Exercise Screen")
    }
    
    override func viewDidLayoutSubviews() {
        playerLayer.frame = videoView.bounds
    }
    
    // MARK: - Custom functions
    
    private func updateView() {
        configureUI()
        configurePlayer()
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
    }
    
    private func configureUI() {
        self.slider.setThumbImage(UIImage(named: "FC Slider Thumb")!, for: .normal)
        self.slider.setThumbImage(UIImage(named: "FC Slider Thumb")!, for: .highlighted)
        
        var counter = 0
        for view in linesStackView.subviews {
            view.backgroundColor = counter <= currentItem ? UIColor(red: 1, green: 1, blue: 1, alpha: 1) : UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
            if counter >= exercises.count {
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
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if object as AnyObject? === player {
            if keyPath == "status" {
                if player.status == .readyToPlay {
                    print("Ready to play")
                    player.play()
                }
            } else if keyPath == "timeControlStatus" {
                if player.timeControlStatus == .playing {
                    
                    print("Playing")
                    loader.remove()
                    self.addTimeObserver()
                    
                }
            }
        }
    }
    
    func addTimeObserver() {
        let interval = CMTime(seconds: 0.01, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        let mainQueue = DispatchQueue.main
        _ = player.addPeriodicTimeObserver(forInterval: interval, queue: mainQueue, using: { time in
            guard let currentItem = self.player.currentItem else {return}
            self.slider.minimumValue = 0
            self.slider.maximumValue = Float(currentItem.duration.seconds) == 0 ? 1 : Float(currentItem.duration.seconds)
            self.slider.value = Float(currentItem.currentTime().seconds)
            
        })
    }
    
    private func loadVideo() {
        
        
        print("Load: current item: ", currentItem)
        let exercise = exercises[currentItem]
        player = AVPlayer(url: exercise.getVideoURL())
        
        let title = "Упражнение \(currentItem + 1):\n\(exercise.name)"
        
        loader.titleLabelText = title
        exerciseNameLabel.text = title
        
        loader.view.frame = self.view.frame
        self.view.addSubview(loader.view)
        
        player.addObserver(self, forKeyPath: "status", options: [.old, .new], context: nil)
        player.addObserver(self, forKeyPath: "timeControlStatus", options: [.old, .new], context: nil)
    }
    
    // MARK: - Gesture actions
    
    @objc private func pauseVideo() {
        player.pause()
        
        let infoPopup = ExerciseInfoPopup.load(from: Popup.exerciseInfo)
        infoPopup.currentItem = self.currentItem
        infoPopup.exercises = self.exercises
        infoPopup.onCloseCompletion = { index in
            
            print("Popup closed: current item: ", index)
            
            if self.currentItem == index {
                self.player.play()
            } else {
                self.currentItem = index
                self.loadVideo()
                self.updateView()
            }
            
        }
        
        self.presentPanModal(infoPopup)
    }
    
    @objc func playerDidFinishPlaying() {
        
        if currentItem == exercises.count - 1 {
            // was last video
            
            if let trainingNumber = trainingNumber {
                State.shared.completeDailyTraining(number: trainingNumber)
            }
            
            let trainingCompletedVC = TrainingCompletedViewController.load(from: Screen.trainingEnded)
            trainingCompletedVC.modalPresentationStyle = .fullScreen
            
            trainingCompletedVC.onDismiss = {
                self.dismiss(animated: true)
                self.dismiss(animated: false)
            }
            
            self.present(trainingCompletedVC, animated: true)
            
            return
        }
        
        currentItem += 1
        self.loadVideo()
        self.updateView()
    }
    
    // MARK: - @IBActions
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        
        self.player.pause()
        
        let alert = UIAlertController(title: "Вы уверены, что хотите выйти?", message: nil, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Да", style: .default) { _ in
            
            self.dismiss(animated: true)
            
        }
        
        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel) { _ in
            self.player.play()
        }
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider, event: UIEvent) {
        
        player.seek(to: CMTimeMake(value: Int64(sender.value * 1000), timescale: 1000))
        
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                player.pause()
            case .moved:
                player.pause()
            case .ended:
                player.play()
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
