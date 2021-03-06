import UIKit
import AVFoundation

class PlayerView: UIView {
    
    public var movieURL: URL?
    private var player: AVPlayer = AVPlayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPlayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupPlayer()
    }

    deinit {
        player.pause()
    }
    
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    public func prepare(with movieURL: URL) {
        self.movieURL = movieURL
    }
    
    public func play() {
        guard let movieURL = movieURL else { return }

        if let _ = player.currentItem {
            player.seek(to: CMTime.zero) { [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.player.play()
            }
        } else {
            let asset = AVURLAsset(url: movieURL, options: nil)
            let playerItem = AVPlayerItem(asset: asset)
            player.replaceCurrentItem(with: playerItem)
            player.play()
        }
    }
    
    public func pause() {
        player.pause()
    }
    
}

extension PlayerView {
    
    private func setupPlayer() {
        if let layer = layer as? AVPlayerLayer {
            layer.player = player
            layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        }
    }
    
}
