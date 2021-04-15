//
//  History.swift
//  ToDoListApp
//
//  Created by zombietux on 2021/04/14.
//

import Foundation

class History: Codable, HistoryManageable {
    private var id: Int
    private var action: String
    private var title: String
    private var fromColumnId: Int
    private var toColumnId: Int?
    private var createdTime: String
    
    init(id: Int, action: String, title: String, fromColumnId: Int, toColumnId: Int?, createdTime: String) {
        self.id = id
        self.action = action
        self.title = title
        self.fromColumnId = fromColumnId
        self.toColumnId = toColumnId
        self.createdTime = createdTime
    }
    
    convenience init() {
        let id = Int()
        let action = ""
        let title = ""
        let fromColumnId = Int()
        let toColumnId = Int()
        let createdTime = ""
        self.init(id: id, action: action, title: title, fromColumnId: fromColumnId, toColumnId: toColumnId, createdTime: createdTime)
    }
    
    func getTitle() -> String {
        return self.title
    }
    
    func getAction() -> String {
        return self.action
    }
    
    func getFromColumnId() -> Int {
        return self.fromColumnId
    }
    
    func getToColumnId() -> Int {
        return self.toColumnId ?? 0
    }
}
