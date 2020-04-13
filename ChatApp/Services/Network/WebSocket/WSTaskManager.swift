//
//  WSTaskManager.swift
//  ChatApp
//
//  Created by Mher Davtyan on 2/3/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import Foundation

struct WSTaskManager {
    static var shared = WSTaskManager()
    
    // MARK: - Memory
    private var webSockets = [String: WSTask]()
    
    // MARK: - Get tasks
    // Get task by path and id
    mutating func get(router: WSTask.Router) -> WSTask {
        let key = router.path + router.id
        
        guard let task = webSockets[key] else {
            webSockets[key] = WSTask(router: router)
            webSockets[key]?.configure()
            return webSockets[key]!
        }
        return task
    }
    
    // Get all tasks
    func getAll() -> [String: WSTask] {
        return webSockets
    }
    
    // Get tasks by path
    func getAll(by router: WSTask.Router) -> [WSTask] {
        let prefix = router.path
        var tasks = [WSTask]()
        
        let tasksDict = webSockets.filter { $0.key.hasPrefix(prefix) }
        tasksDict.forEach { (_, value) in
            tasks.append(value)
        }
        
        return tasks
    }
    
    // MARK: - Add tasks
    mutating func addWS(router: WSTask.Router) {
        let key = router.path + router.id
        
        if !webSockets.contains(where: { $0.key == key }) {
            webSockets[key] = WSTask(router: router)
            webSockets[key]?.configure()
        }
    }
    
    // MARK: - Connection
    func open() {
        if let id = User.current?.id {
            WSTaskManager.shared.addWS(router: .chats)
            WSTaskManager.shared.addWS(router: .notifier(id: id))
        }
    }
    
    func closeAll() {
        webSockets.forEach { dict in
            dict.value.close(with: .goingAway)
        }
    }
}
