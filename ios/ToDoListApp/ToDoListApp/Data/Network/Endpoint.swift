//
//  Endpoint.swift
//  ToDoListApp
//
//  Created by zombietux on 2021/04/08.
//

import Foundation
import Combine

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

//1. URL 생성
extension Endpoint {

    var url: URL {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "ec2-3-36-241-44.ap-northeast-2.compute.amazonaws.com"
        components.port = 8080
        components.path = "\(path)"

        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }

        return url
    }
}

extension Endpoint {

    //GET용
    static func cards(state: State) -> Self {
        return Endpoint(path: "/card/\(state.rawValue)")
    }
    
    //POST용
    static func add(columnId: Int) -> Self {
        return Endpoint(path: "/card/\(columnId+1)")
    }
    
    static func remove(id: Int) -> Self {
        print(Endpoint(path: "/card/\(id)").url)
        return Endpoint(path: "/card/\(id)")
    }
    
    static func update(id: Int) -> Self {
        return Endpoint(path: "/card/\(id)")
    }
    
    static func move(id: Int, toColumn: Int, toIndexOfColumn: Int) -> Self {
        print(Endpoint(path: "/card/\(id)/move/\(toColumn)/\(toIndexOfColumn+1)").url)
        return Endpoint(path: "/card/\(id)/move/\(toColumn)/\(toIndexOfColumn+1)")
    }
}
enum State: Int {
    case todo = 1
    case doing = 2
    case done = 3

    var state: Int {
        return rawValue
    }
}

