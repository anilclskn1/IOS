//
//  Router.swift
//  CryptoViper
//
//  Created by AnilyTugce on 9.10.2022.
//

import Foundation

protocol AnyRouter {
    static func startExecution() -> AnyRouter
}

class CryptoRouter : AnyRouter {
    static func startExecution() -> AnyRouter {
        let router = CryptoRouter
        
        
        return router
    }
}
