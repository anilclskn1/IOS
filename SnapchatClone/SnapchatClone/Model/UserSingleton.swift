//
//  UserSingleton.swift
//  SnapchatClone
//
//  Created by AnilyTugce on 8.10.2022.
//

import Foundation

class UserSingleton {
    
    static let sharedUserInfo = UserSingleton()
    
    var email = ""
    var username = ""
    private init() {
        
    }
}
