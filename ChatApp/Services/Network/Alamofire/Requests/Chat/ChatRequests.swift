//
//  ChatRequests.swift
//  ChatApp
//
//  Created by Mher Davtyan on 2/21/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import Foundation

struct ChatRequests {
    
    // MARK: - POST Requests
    static func create(memberId: String, success: @escaping (Chat?) -> Void, fail: @escaping (String) -> Void) {
        Loading.shared.show()
        AFManager.performRequest(router: ChatRouter.single(id: memberId),
                                 decoder: CoreDataWrapper.shared.jsonDecoder) { (response: AFResponse<Chat>) in
            Loading.shared.hide()
            if response.isSuccess {
                success(response.value)
            } else {
                fail(response.error?.localizedDescription ?? "")
            }
        }
    }
    
    static func group(name: String, success: @escaping (Chat?) -> Void, fail: @escaping (String) -> Void) {
        Loading.shared.show()
        AFManager.performRequest(router: ChatRouter.group(name: name),
                                 decoder: CoreDataWrapper.shared.jsonDecoder) { (response: AFResponse<Chat>) in
            Loading.shared.hide()
            if response.isSuccess {
                success(response.value)
            } else {
                fail(response.error?.localizedDescription ?? "")
            }
        }
    }
    
    // MARK: - PUT Requests
    static func invite(id: String, u_id: String, success: @escaping (Chat?) -> Void, fail: @escaping (String) -> Void) {
        Loading.shared.show()
        AFManager.performRequest(router: ChatRouter.invite(id: id, u_id: u_id),
                                 decoder: CoreDataWrapper.shared.jsonDecoder) { (response: AFResponse<Chat>) in
            Loading.shared.hide()
            if response.isSuccess {
                
                success(response.value)
            } else {
                fail(response.error?.localizedDescription ?? "")
            }
        }
    }
}
