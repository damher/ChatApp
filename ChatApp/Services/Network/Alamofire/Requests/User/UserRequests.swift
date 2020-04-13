//
//  UserRequests.swift
//  ChatApp
//
//  Created by Mher Davtyan on 1/23/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import Foundation

struct UserRequests {
    
    // MARK: - GET Requests
    static func getUsers(success: @escaping ([User]?) -> Void, fail: @escaping (String) -> Void) {
        Loading.shared.show()
        AFManager.performRequest(router: UserRouter.all,
                                        decoder: CoreDataWrapper.shared.jsonDecoder) { (response: AFResponse<[User]>) in
            Loading.shared.hide()
            if response.isSuccess {
                success(response.value)
            } else {
                fail(response.error?.localizedDescription ?? "")
            }
        }
    }
    
    static func searchUsers(_ name: String, success: @escaping ([User]?) -> Void, fail: @escaping (String) -> Void) {
        Loading.shared.show()
        AFManager.performRequest(router: UserRouter.search(name: name),
                                        decoder: CoreDataWrapper.shared.jsonDecoder) { (response: AFResponse<[User]>) in
            Loading.shared.hide()
            if response.isSuccess {
                success(response.value)
            } else {
                fail(response.error?.localizedDescription ?? "")
            }
        }
    }
    
    // MARK: - POST Requests
    static func register(_ data: RegisterData, success: @escaping (User?) -> Void, fail: @escaping (String) -> Void) {
        Loading.shared.show()
        AFManager.performRequest(router: UserRouter.register(data: data),
                                 decoder: CoreDataWrapper.shared.jsonDecoder) { (response: AFResponse<User>) in
            Loading.shared.hide()
            if response.isSuccess {
                success(response.value)
            } else {
                fail(response.error?.localizedDescription ?? "")
            }
        }
    }
    
    static func login(_ email: String, _ password: String, success: @escaping (User?) -> Void, fail: @escaping (String) -> Void) {
        Loading.shared.show()
        AFManager.performRequest(router: UserRouter.login(email: email, password: password),
                                 decoder: CoreDataWrapper.shared.jsonDecoder) { (response: AFResponse<User>) in
            Loading.shared.hide()
            if response.isSuccess {
                if let user = response.value {
                    user.is_current = true
                    CoreDataManager.shared.saveUser(user)
                    UserDefaultsManager.token = user.token
                    UserDefaultsManager.password = password
                    WSTaskManager.shared.open()
                }
                success(response.value)
            } else {
                fail(response.error?.localizedDescription ?? "")
            }
        }
    }
    
    static func logout(success: @escaping (User?) -> Void, fail: @escaping (String) -> Void) {
        Loading.shared.show()
        AFManager.performRequest(router: UserRouter.logout,
                                 decoder: CoreDataWrapper.shared.jsonDecoder) { (response: AFResponse<User>) in
            Loading.shared.hide()
            if response.isSuccess {
                success(response.value)
            } else {
                fail(response.error?.localizedDescription ?? "")
            }
        }
    }
    
    // MARK: - PUT Requests
    static func changeName(_ name: String, success: @escaping (User?) -> Void, fail: @escaping (String) -> Void) {
        Loading.shared.show()
        AFManager.performRequest(router: UserRouter.changeName(name: name),
                                 decoder: CoreDataWrapper.shared.jsonDecoder) { (response: AFResponse<User>) in
            Loading.shared.hide()
            if response.isSuccess {
                success(response.value)
                CoreDataManager.shared.updateCurrentUserName(response.value)
            } else {
                fail(response.error?.localizedDescription ?? "")
            }
        }
    }
    
    static func changePassword(_ password: String, success: @escaping (User?) -> Void, fail: @escaping (String) -> Void) {
        Loading.shared.show()
        AFManager.performRequest(router: UserRouter.changePassword(password: password),
                                 decoder: CoreDataWrapper.shared.jsonDecoder) { (response: AFResponse<User>) in
            Loading.shared.hide()
            if response.isSuccess {
                success(response.value)
                UserDefaultsManager.password = password
            } else {
                fail(response.error?.localizedDescription ?? "")
            }
        }
    }
}
