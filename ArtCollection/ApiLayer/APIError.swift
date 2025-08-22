////
////  APIErrors.swift
////  ArtCollection
////
////  Created by Динар Хайруллин on 21.08.2025.
////

import Foundation

enum APIError: Error {
    case networkError(Error)
    case invalidResponse
    case decodingError(Error)

    var localizedDescription: String {
        switch self {
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .invalidResponse:
            return "Invalid response from the server."
        case .decodingError(let error):
            return "Decoding error: \(error.localizedDescription)"
        }
    }
}
