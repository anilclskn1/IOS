//
//  MusicianStruct.swift
//  AdvancedSwiftProject
//
//  Created by AnilyTugce on 4.10.2022.
//

import Foundation

struct MusicianStruct {
    var name : String
    var age : Int
    var instrument : String
    
    
   mutating func happyBirthday() {
        age += 1
    }
}
