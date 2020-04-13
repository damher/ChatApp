//
//  Loading.swift
//  ChatApp
//
//  Created by Mher Davtyan on 11/26/19.
//  Copyright © 2019 Mher Davtyan. All rights reserved.
//

import UIKit

final class Loading {
    static let shared = Loading()
    private init() {}
    private var loadingView: LoadingView?

    private var loading: LoadingView? {
        if loadingView == nil { loadingView = LoadingView.shared }
        return loadingView
    }
    
    func show() { loading?.show() }
    func hide() { loading?.remove() }
}
