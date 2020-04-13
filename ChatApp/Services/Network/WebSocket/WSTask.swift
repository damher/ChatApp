//
//  WSTask.swift
//  ChatApp
//
//  Created by Mher Davtyan on 1/22/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import UIKit

class WSTask {
    
    // MARK: - Properties
    private var router: WSTask.Router
    var task: URLSessionWebSocketTask?
    
    // MARK: - Initialization
    required init(router: WSTask.Router) {
        self.router = router
    }
    
    // MARK: - Methods
    func configure() {
        let urlSession = URLSession.init(configuration: .default)
        if let url = URL(string: "\(Constant.BaseURL.ws)/\(router.path)/\(router.id)") {
            var request = URLRequest(url: url)
            
            if let id = User.current?.id {
                request.setValue(UserDefaultsManager.token, forHTTPHeaderField: Constant.Key.token)
                request.setValue(id, forHTTPHeaderField: Constant.Key.id)
            }
            
            task = urlSession.webSocketTask(with: request)
        }
        
        task?.resume()
        receiveData()
    }
    
    // MARK: - Connection
    func connect(_ data: Data = Data()) {
        let data = URLSessionWebSocketTask.Message.data(data)
        
        task?.send(data) { error in
            if let error = error {
                print("WebSocket couldn’t send data because: \(error)")
            }
        }
    }
    
    func sendMessage(_ text: String) {
        // Create data
        guard let u_id = User.current?.id else { return }
        let msg = MessageData(text: text, senderId: u_id, chatId: router.id)
        // Encode data
        guard let encodedData = try? JSONEncoder().encode(msg) else { return }
        connect(encodedData)
    }
    
    func close(with closeCode: URLSessionWebSocketTask.CloseCode) {
        task?.cancel(with: closeCode, reason: nil)
    }
    
    // MARK: - Receive data
    private func receiveData() {
        task?.receive { [weak self] result in
            switch result {
            case .failure(let error):
                print("Failed to receive data: \(error)")
                self?.configure()
            case .success(let message):
                switch message {
                case .data(let data):
                    self?.router.dataHandler(data: data)
                default:
                    fatalError()
                }
            }
            
            self?.receiveData()
        }
    }
}
