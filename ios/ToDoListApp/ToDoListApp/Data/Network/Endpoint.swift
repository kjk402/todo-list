//
//  Endpoint.swift
//  ToDoListApp
//
//  Created by zombietux on 2021/04/08.
//

import Foundation
import Combine

struct Endpoint {
    private var path: String
    var url: URL {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "ec2-3-36-241-44.ap-northeast-2.compute.amazonaws.com"
        components.port = 8080
        components.path = "\(path)"
        
          let url = components.url!
        
        return url
    }

    static func cards(state: CardState) -> Self {
        return Endpoint(path: "/card/\(state.rawValue)")
    }
    
    static func add(columnId: Int) -> Self {
        return Endpoint(path: "/card/\(columnId+1)")
    }
    
    static func remove(id: Int) -> Self {
        return Endpoint(path: "/card/\(id)")
    }
    
    static func update(id: Int) -> Self {
        return Endpoint(path: "/card/\(id)")
    }
    
    static func move(id: Int, toColumn: Int, toIndexOfColumn: Int) -> Self {
        return Endpoint(path: "/card/\(id)/move/\(toColumn)/\(toIndexOfColumn+1)")
    }
    
    static func histories() -> Self {
        return Endpoint(path: "/history")
    }
}

enum CardState: Int {
    case todo = 1
    case doing = 2
    case done = 3

    var state: Int {
        return rawValue
    }
}
