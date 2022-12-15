//
//  AVAsset+.swift
//  TeddyBear2022
//  
//  Created by テディベア on 2022/12/15
//  
//

import AVFoundation
import AVKit

extension AVAsset {

    func generateThumbnail(completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            let imageGenerator = AVAssetImageGenerator(asset: self)
            let time = CMTime(seconds: 0.0, preferredTimescale: 600)
            let times = [NSValue(time: time)]
            imageGenerator.generateCGImagesAsynchronously(forTimes: times, completionHandler: { _, image, _, _, _ in
                if let image = image {
                    completion(UIImage(cgImage: image, scale: 0, orientation: .right))
                } else {
                    completion(nil)
                }
            })
        }
    }
}

