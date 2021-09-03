//
//  VideoTableCell.swift
//  BlogShowcase
//
//  Created by kwanghyun won on 2021/01/14.
//  Copyright © 2021 wonkwh. All rights reserved.
//

import UIKit
import AVFoundation
import Nuke

final class VideoTableCell: UITableViewCell {
    private var requestId: Int = 0
    private var videoURL: URL?
    private var task: ImageTask?

    private let spinner: UIActivityIndicatorView
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    private var playerLooper: AnyObject?

//    deinit {
//        prepareForReuse()
//    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        spinner = UIActivityIndicatorView(style: .medium)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(spinner)
        spinner.centerInSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        videoURL.map(TemporaryVideoStorage.shared.removeData(for:))
        playerLayer?.removeFromSuperlayer()
        playerLayer = nil
        player = nil
    }

    func setVideo(with url: URL) {
        let pipeline = ImagePipeline.shared
        let request = ImageRequest(url: url)

        if let image = pipeline.cachedImage(for: request) {
            return display(image)
        }

        spinner.startAnimating()
        task = pipeline.loadImage(with: request) { [weak self] result in
            self?.spinner.stopAnimating()
            if case let .success(response) = result {
                self?.display(response.container)
            }
        }
    }

    private func display(_ container: ImageContainer) {
        guard let data = container.data else {
            return
        }

        assert(container.userInfo["mime-type"] as? String == "video/mp4")

        self.requestId += 1
        let requestId = self.requestId

        TemporaryVideoStorage.shared.storeData(data) { [weak self] url in
            guard self?.requestId == requestId else { return }
            self?._playVideoAtURL(url)
        }
    }

    private func _playVideoAtURL(_ url: URL) {
        let playerItem = AVPlayerItem(url: url)
        let player = AVQueuePlayer(playerItem: playerItem)
        let playerLayer = AVPlayerLayer(player: player)
        
        self.initAspectRatioOfVideo(with: url)
        if let aspectRaio = mediaAspectRatio {
            playerLayer.videoGravity = (aspectRaio > 1.0) ? .resizeAspectFill : .resizeAspect
        }
        
        self.playerLooper = AVPlayerLooper(player: player, templateItem: playerItem)

        contentView.layer.addSublayer(playerLayer)
        playerLayer.frame = contentView.bounds

        player.play()

        self.player = player
        self.playerLayer = playerLayer
    }
    
    var mediaAspectRatio: Double?

    private func initAspectRatioOfVideo(with fileURL: URL) {
      let resolution = resolutionForLocalVideo(url: fileURL)

      guard let width = resolution?.width, let height = resolution?.height else {
         return
      }

      mediaAspectRatio = Double(height / width)
    }
    
    private func resolutionForLocalVideo(url: URL) -> CGSize? {
        guard let track = AVURLAsset(url: url).tracks(withMediaType: .video).first else { return nil }
       let size = track.naturalSize.applying(track.preferredTransform)
       return CGSize(width: abs(size.width), height: abs(size.height))
    }
    
    func pause() {
        self.player?.pause()
    }
    
    func replay() {
        self.player?.pause()
        self.player?.seek(to: CMTime.zero)
        self.player?.play()
    }
}
