////
////  ArtApi.swift
////  ArtCollection
////
////  Created by Динар Хайруллин on 21.08.2025.
////

import Foundation

struct ArtAPI {
    static let baseURL = "https://collectionapi.metmuseum.org/public/collection/v1"

    static func fetchAllObjectIDs(completion: @escaping (Result<[Int], APIError>) -> Void) {
        let urlString = "\(baseURL)/objects"
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidResponse))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }

            do {
                let artObjects = try JSONDecoder().decode(ArtObjects.self, from: data)
                completion(.success(artObjects.objectIDs))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        task.resume()
    }

    static func fetchArtObject(with objectID: Int, completion: @escaping (Result<ArtObject, APIError>) -> Void) {
        let urlString = "\(baseURL)/objects/\(objectID)"
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidResponse))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }

            do {
                let artObject = try JSONDecoder().decode(ArtObject.self, from: data)
                completion(.success(artObject))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        task.resume()
    }
}
