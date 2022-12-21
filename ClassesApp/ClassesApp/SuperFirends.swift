//
//  SuperFirends.swift
//  ClassesApp
//
//  Created by AnilyTugce on 4.09.2022.
//

import Foundation

//Inheritance = miras. I can add extra properties to funcs by overriding and call super

class SuperFriends : Friends
{
    
    override func tell() {
        super.tell()
        print("I am really grateful to have you!")
    }
    
}
