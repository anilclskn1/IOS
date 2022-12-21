//
//  main.swift
//  ProtocolSwiftProject
//
//  Created by AnilyTugce on 4.10.2022.
//

import Foundation

protocol Running {
    func myRun()
}

class Animal : Running {
    func myRun() {
        print("Running")
    }
    
}

struct Dog : Running {
    func myRun() {
        print("Dog can run")
    }
}

let myDog = Dog()
myDog.myRun()
