//
//  NetworkManager.swift
//  ToDoListApp
//
//  Created by zombietux on 2021/04/08.
//

import Foundation
import Combine

protocol HttpMethodProtocol: class {

    func get<T>(type: [T].Type, url: URL) -> AnyPublisher<[T], Error> where T: Decodable
    func post<T>(title: String, contents: String, url: URL) -> AnyPublisher<T, Error> where T: Decodable
    func put<T>(title: String, contents: String, url: URL) -> AnyPublisher<T, Error> where T: Decodable
}

final class NetworkManager: HttpMethodProtocol {
    
    func get<T>(type: T.Type,
                url: URL
    ) -> AnyPublisher<T, Error> where T : Decodable {
        
        let urlRequest = URLRequest(url: url)
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func post<T>(title: String, contents: String, url: URL) -> AnyPublisher<T, Error> where T: Decodable {
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
//        let body = try? JSONEncoder().encode(Card(title: title, contents: contents))
        let json: [String: Any] = ["title": title,
                                   "contents": contents
                                  ]

        let body = try? JSONSerialization.data(withJSONObject: json)

        request.httpBody = body
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func put<T>(title: String, contents: String, url: URL) -> AnyPublisher<T, Error> where T: Decodable {
        var request = URLRequest(url: url)
        
        request.httpMethod = "PUT"
        print(title, contents)
        let body = try? JSONEncoder().encode(Card(title: title, contents: contents))
        request.httpBody = body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
