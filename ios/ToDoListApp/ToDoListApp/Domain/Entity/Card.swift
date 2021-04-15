//
//  Card.swift
//  ToDoListApp
//
//  Created by zombietux on 2021/04/06.
//

import Foundation

class Card: CardManageable, Codable {
    
    private var id: Int?
    private var title: String?
    private var contents: String?
    private var columnId: Int?
    private var createdTime: String?
    private var flag: Double?
    
    init(id: Int?, title: String, contents: String, columnId: Int?, createdTime: String?, flag: Double?) {
        self.id = id
        self.title = title
        self.contents = contents
        self.columnId = columnId
        self.createdTime = createdTime
        self.flag = flag
    }
    
    convenience init(title: String, contents: String) {
        self.init(id: nil, title: title, contents: contents, columnId: nil, createdTime: nil, flag: nil)
    }
    
    convenience init() {
        let id = Int()
        let title = ""
        let contents = ""
        let columnId = Int()
        let createdTime = String()
        let flag = Double()
        self.init(id: id, title: title, contents: contents, columnId: columnId, createdTime: createdTime, flag: flag)
    }
    
    func add() {
    }
    
    func edit(title: String, contents: String) {
        self.title = title
        self.contents = contents
    }
    
    func delete() {
        
    }
    
    func goToDone() {
        self.columnId = 3
    }
    
    func getTitle() -> String {
        return self.title ?? "타이틀 가져오기 실패"
    }
    
    func getContents() -> String {
        return self.contents ?? "content 가져오기 실패"
    }
    
    func getId() -> Int? {
        return self.id
    }
}
