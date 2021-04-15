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
    func delete(id: Int, url: URL) -> AnyPublisher<Int, NetworkError>
    func move<T>(url: URL) -> AnyPublisher<T, Error> where T: Decodable
}

final class NetworkManager: HttpMethodProtocol {
    
    func get<T>(type: [T].Type, url: URL) -> AnyPublisher<[T], Error> where T : Decodable {
        
        let urlRequest = URLRequest(url: url)
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: [T].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func post<T>(title: String, contents: String, url: URL) -> AnyPublisher<T, Error> where T: Decodable {
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        let formData: [String: Any] = ["title" : title, "contents" : contents]

        // key/value 형태의 데이터를 string 형태로 변환하는 부분
        let formDataString = (formData.compactMap({ (key, value) -> String in return "\(key)=\(value)" }) as Array).joined(separator: "&")

        request.httpBody = formDataString.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func put<T>(title: String, contents: String, url: URL) -> AnyPublisher<T, Error> where T: Decodable {
        var request = URLRequest(url: url)
        
        request.httpMethod = "PUT"
        
        let formData: [String: Any] = ["title" : title, "contents" : contents]
        
        let formDataString = (formData.compactMap({ (key, value) -> String in return "\(key)=\(value)" }) as Array).joined(separator: "&")
 
        request.httpBody = formDataString.data(using: .utf8)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
 
    
    func delete(id: Int, url: URL) -> AnyPublisher<Int, NetworkError> {
        var request = URLRequest(url: url)
        
        request.httpMethod = "DELETE"

        return URLSession.shared.dataTaskPublisher(for: request)
    
            .tryMap{ data , response -> Int in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.httpError
                }
                guard 200..<300 ~= httpResponse.statusCode else {
                    throw NetworkError.httpError
                }
                return httpResponse.statusCode
            }
            .mapError {$0 as! NetworkError }
            .eraseToAnyPublisher()
    }
    
    func move<T>(url: URL) -> AnyPublisher<T, Error> where T: Decodable {
        var request = URLRequest(url: url)
        
        request.httpMethod = "PUT"

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
    }
}

enum NetworkError: Error {
    case urlError
    case httpError
}
