//
//  NetworkingManager.swift
//  ios-crypto-app
//
//  Created by Hridayan Phukan on 20/03/25.
//

import Foundation
import Combine

class NetworkingManager {
    
    
    enum NetowrkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url):
                return "Bad URL Response from : \(url)"
            case .unknown:
                return "Unknown Error"
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try
                handleURLResponse(output: $0, url: url)
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetowrkingError.badURLResponse(url: url)
        }
        
        return output.data
    }
    
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
            case .failure(let error):
                print(error.localizedDescription)
            case .finished:
                break
        }
    }
}
