//
//  ImageLoader.swift
//  alohomora
//
//  Created by Janine Leal on 16/07/26.
//

import UIKit

final class ImageLoader {
    static let shared = ImageLoader()
    private let cache = NSCache<NSURL, UIImage>()

    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) -> URLSessionDataTask? {
        if let cachedImage = cache.object(forKey: url as NSURL) {
            completion(cachedImage)
            return nil
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data, let image = UIImage(data: data), error == nil else {
                DispatchQueue.main.async { completion(nil) }
                return
            }

            self?.cache.setObject(image, forKey: url as NSURL)

            DispatchQueue.main.async {
                completion(image)
            }
        }

        task.resume()
        return task
    }
}
