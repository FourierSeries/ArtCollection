//
//  ImageAPI.swift
//  ArtCollection
//
//  Created by Динар Хайруллин on 23.08.2025.
//

import UIKit

class ImageAPI {
    static func loadImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                let error = NSError(domain: "ImageAPI", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to load image"])
                completion(.failure(error))
                return
            }
            completion(.success(image))
        }
        task.resume()
    }
}
