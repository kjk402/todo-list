//
//  HistoryUseCasePort.swift
//  ToDoListApp
//
//  Created by zombietux on 2021/04/14.
//

import Foundation
import Combine

protocol HistoryUseCasePort {
    func get() -> AnyPublisher<Histories, Error>
}
