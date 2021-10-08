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
    
    // Reference for the player view.
    private var playerView: FCPlayerView!
    
    var player: AVPlayer = AVPlayer()
    var playerLayer: AVPlayerLayer!
    
    var exercises: [Exercise] = []
    var trainingNumber: Int?
    
    var videoIndex = 0
    
    let loader = ExerciseLoadingViewController.load(from: Screen.exerciseLoading)
    
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPlayerView()
        loadVideo()
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
        setupGestures()
        State.shared.setCurrentScreen(to: "Exercise Screen")
    }
    
    override func viewDidLayoutSubviews() {
        playerView.playerLayer.frame = videoView.bounds
    }
    
    // MARK: - Custom functions
    
    private func configureUI() {
        self.slider.setThumbImage(UIImage(named: "FC Slider Thumb")!, for: .normal)
        self.slider.setThumbImage(UIImage(named: "FC Slider Thumb")!, for: .highlighted)
        
        
    }
    
    private func configureHeader() {
        
        for i in 0 ..< linesStackView.subviews.count {
            
            let line = linesStackView.subviews[i]
            
            line.backgroundColor = i <= videoIndex ? .FCWhite : .FCWhite.withAlphaComponent(0.3)
            line.isHidden = i >= exercises.count
            line.capsuleCorners()
            
        }
        
        self.exerciseNameLabel.text = L.get(key: L.Training.exercise, args: videoIndex + 1, exercises[videoIndex].name)
        
    }
    
    private func setupPlayerView() {
        playerView = FCPlayerView()
        videoView.addSubview(playerView)
        
        playerView.translatesAutoresizingMaskIntoConstraints = false
        playerView.leadingAnchor.constraint(equalTo: videoView.leadingAnchor).isActive = true
        playerView.trailingAnchor.constraint(equalTo: videoView.trailingAnchor).isActive = true
        playerView.heightAnchor.constraint(equalTo: videoView.widthAnchor).isActive = true
        playerView.centerYAnchor.constraint(equalTo: videoView.centerYAnchor).isActive = true
        
        
    }
    
    private func configurePlayer() {
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        videoView.layer.addSublayer(playerLayer)
    }
    
    private func setupGestures() {
        videoView.addTapGesture(target: self, action: #selector(pauseVideo))
    }
    
    
    private func updateVideoPlayerSlider() {
        guard let currentTime = playerView.player?.currentTime() else { return }
        let currentTimeInSeconds = CMTimeGetSeconds(currentTime)
        slider.value = Float(currentTimeInSeconds)
        if let currentItem = playerView.player?.currentItem {
            let duration = currentItem.duration
            if (CMTIME_IS_INVALID(duration)) {
                return;
            }
            let currentTime = currentItem.currentTime()
            slider.value = Float(CMTimeGetSeconds(currentTime) / CMTimeGetSeconds(duration))
        }
    }
    
    private func loadVideo(for index: Int? = nil) {
        
        if let index = index {
            self.videoIndex = index
        }
        
        let exercise = exercises[videoIndex]
        
        self.showLoader(number: self.videoIndex + 1, name: exercise.name)
        
        playerView.load(from: exercise.getVideoURL())
        print("Load: index: ", videoIndex)
        
        self.slider.minimumValue = 0
        
        playerView.onReadyToPlay = { }
        
        playerView.onStartPlaying = {
            self.hideLoader()
            let interval = CMTime(seconds: 0.01, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
            self.playerView.player?.addPeriodicTimeObserver(forInterval: interval, queue: .main, using: { elapsedTime in
                self.updateVideoPlayerSlider()
            })
            print("Started to play")
        }
        
        self.configureHeader()
    }
    
    private func loadNextVideo() {
        
        guard self.videoIndex != exercises.count - 1 else {
            
            // Last exercise
            playerView.pause()
            
            if let trainingNumber = trainingNumber {
                State.shared.completeDailyTraining(number: trainingNumber)
            }
            
            let trainingCompletedVC = TrainingCompletedViewController.load(from: Screen.trainingEnded)
            trainingCompletedVC.modalPresentationStyle = .fullScreen
            
            trainingCompletedVC.onDismiss = {
                self.dismiss(animated: false)
                self.dismiss(animated: true)
            }
            
            self.present(trainingCompletedVC, animated: true)
            
            return
        }
        
        self.loadVideo(for: self.videoIndex + 1)
        
    }
    
    private func showLoader(number: Int, name: String) {
        
        loader.exerciseName = name
        loader.exerciseNumber = number
        
        loader.view.frame = self.view.frame
        self.view.addSubview(loader.view)
        
    }
    
    private func hideLoader() {
        loader.remove()
    }
    
    
    // MARK: - Gesture actions
    
    @objc private func pauseVideo() {
        
        playerView.pause()
        
        let infoPopup = ExerciseInfoPopup.load(from: Popup.exerciseInfo)
        infoPopup.currentItem = self.videoIndex
        infoPopup.exercises = self.exercises
        infoPopup.onCloseCompletion = { index in
            
            print("Popup closed: index: ", index)
            
            if self.videoIndex == index {
                self.playerView.play()
            } else {
                self.loadVideo(for: index)
            }
            
        }
        
        self.presentPanModal(infoPopup)
    }
    
    @objc func playerDidFinishPlaying() {
        
        print("Finished")
        self.loadNextVideo()
        
    }
    
    // MARK: - @IBActions
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        
        self.player.pause()
        
        let alert = UIAlertController(title: L.get(key: L.Alert.Training.title), message: nil, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: L.get(key: L.Alert.Action.yes), style: .default) { _ in
            self.dismiss(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: L.get(key: L.Alert.Action.cancel), style: .cancel) { _ in
            self.player.play()
        }
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider, event: UIEvent) {
        
        guard let duration = playerView.player?.currentItem?.duration else { return }
        let value = Float64(slider.value) * CMTimeGetSeconds(duration)
        let seekTime = CMTime(value: CMTimeValue(value), timescale: 1)
        playerView.player?.seek(to: seekTime )
        
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                playerView.pause()
            case .moved:
                playerView.pause()
            case .ended:
                playerView.play()
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
