//
//  Friends.swift
//  ClassesApp
//
//  Created by AnilyTugce on 4.09.2022.
//

import Foundation


// Enum provides to seperate data acording to written types and you can specify it
// just like Strings. e.g = var type : Bestway = .funny

enum BestWay {
    case funny
    case serious
    case tall
    case keko
    case handsome
    case reliable
}

class Friends {
    
    var name : String
    var age : Int
    var job : String
    var type : BestWay
    
    // as seen, we defined variables above but they are not initialized yet
    // we pass the values from main to this class by using init function
    
    init(nameInit : String, ageInit : Int, jobInit : String, typeInit : BestWay){
        name = nameInit
        age = ageInit
        job = jobInit
        type = typeInit
    }
    
    
    //If below func would be private. I couldn't access it from main and inheritance class
    //When i call super.tell
    
    func tell (){
        print("Good friends i have...")
    }
    
}

