import UIKit
import AVFoundation

class FCPlayerView: UIView {
    
    // MARK: - Variables
    
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    public var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }
        
    var playerLayer: AVPlayerLayer {
        let playerLayer = layer as! AVPlayerLayer
        playerLayer.videoGravity = .resizeAspectFill
        return playerLayer
    }
    
    private var playerItemContext = 0

    // Keep the reference and use it to observe the loading status.
    private var playerItem: AVPlayerItem?
    
    private var isPlaying: Bool = false
    
    public var onLoadingStart: (() -> ()) = {}
    public var onReadyToPlay: (() -> ()) = {}
    public var onStartPlaying: (() -> ()) = {}
    
    // MARK: - Awake functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Custom functions
    
    private func setUpAsset(with url: URL, completion: ((_ asset: AVAsset) -> Void)?) {
        let asset = AVAsset(url: url)
        asset.loadValuesAsynchronously(forKeys: ["playable"]) {
            var error: NSError? = nil
            let status = asset.statusOfValue(forKey: "playable", error: &error)
            switch status {
            case .loaded:
                completion?(asset)
            case .failed:
                print(".failed")
            case .cancelled:
                print(".cancelled")
            default:
                print("default")
            }
        }
    }
    
    private func setUpPlayerItem(with asset: AVAsset) {
        playerItem = AVPlayerItem(asset: asset)
        playerItem?.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), options: [.old, .new], context: &playerItemContext)
            
        DispatchQueue.main.async { [self] in
            self.player = AVPlayer(playerItem: self.playerItem!)
            self.player?.addObserver(self, forKeyPath: #keyPath(AVPlayer.timeControlStatus), options: [.old, .new], context: &playerItemContext)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        // Only handle observations for the playerItemContext
        guard context == &playerItemContext else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
            
        if keyPath == #keyPath(AVPlayerItem.status) {
            let status: AVPlayerItem.Status
            if let statusNumber = change?[.newKey] as? NSNumber {
                status = AVPlayerItem.Status(rawValue: statusNumber.intValue)!
            } else {
                status = .unknown
            }
            // Switch over status value
            switch status {
            case .readyToPlay:
                print(".readyToPlay")
                player?.play()
                self.onReadyToPlay()
                self.isPlaying = false
            case .failed:
                print(".failed")
            case .unknown:
                print(".unknown")
            @unknown default:
                print("@unknown default")
            }
        } else if keyPath == #keyPath(AVPlayer.timeControlStatus) {
            
            let status: AVPlayer.TimeControlStatus
            if let statusNumber = change?[.newKey] as? NSNumber {
                status = AVPlayer.TimeControlStatus(rawValue: statusNumber.intValue)!
            } else {
                status = .paused
            }
            
            // Switch over status value
            switch status {
            case .paused:
                print(".paused")
                onPauseCompletion()
                self.isPlaying = false
            case .waitingToPlayAtSpecifiedRate:
                print(".waitingToPlayAtSpecifiedRate")
            case .playing:
                print(".playing")
                !isPlaying ? self.onStartPlaying() : ()
                isPlaying = true
            @unknown default:
                print("@unknown default")
            }
            
        }
    }
    
    public var onPauseCompletion: (()->()) = {}
    
    public func load(from url: URL) {
        self.onLoadingStart()
        setUpAsset(with: url) { [weak self] (asset: AVAsset) in
            self?.setUpPlayerItem(with: asset)
        }
    }
    
    public func play() {
        self.player?.play()
    }
    
    public func pause() {
        self.player?.pause()
    }
    
    deinit {
        playerItem?.removeObserver(self, forKeyPath: #keyPath(AVPlayerItem.status))
        player?.removeObserver(self, forKeyPath: #keyPath(AVPlayer.timeControlStatus))
        print("deinit of PlayerView")
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
