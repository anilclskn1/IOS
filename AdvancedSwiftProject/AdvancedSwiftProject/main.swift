//
//  main.swift
//  AdvancedSwiftProject
//
//  Created by AnilyTugce on 4.10.2022.
//

import Foundation

let jamesClass = MusicianClass(nameInput: "James", ageInput: 50, instrumentInput: "Guitar")

//print(jamesClass.instrument)

var anilStruct = MusicianStruct(name: "Anıl", age: 23, instrument: "Violin")

//print(anilStruct.instrument)


jamesClass.age = 51

//print(jamesClass.age)

anilStruct.age = 20

//print(anilStruct.age)


//REFERENCE VS VALUE
let copyJames = jamesClass
var copyAnil = anilStruct

//print(copyJames.age)
//print(copyAnil.age)

copyJames.age = 58
copyAnil.age = 58

//print(copyJames.age)
//print(copyAnil.age)

//print(jamesClass.age)
//print(anilStruct.age)

//print(jamesClass.age)
jamesClass.happyBirthday()
//print(jamesClass.age)




// TUPLE

let myTuple = (1,3)
//print(myTuple.1)

var myTuple2 = (1,3,5)
myTuple2.1 = 10
//print(myTuple2.1)

let myTuple3 = ("Atil", 100)
let myTuple4 = (10,[10,20,30])
//print(myTuple4.1[1])

let predefinedTuple : (String, String)
predefinedTuple.0 = "Anil"
predefinedTuple.1 = "CLSKN"
//print(predefinedTuple)

let newTuple = (name : "Anil", age : 50)
//print(newTuple.name)



//GUARD LET VS IF LET
func convertToIntegerGuard(number : String) -> Int {
    guard let myInt = Int(number) else {
        return 0
    }
    return myInt
}

func convertToIntegerIf(number : String) -> Int {
    if let myInt = Int(number) {
        return myInt
    } else {
        return 0;
    }
}

let myNumber = "5"
//print(convertToIntegerIf(number: myNumber))
//print(convertToIntegerGuard(number: myNumber))


//SWITCH CASE
let myNum = 11
let myRemainder = 11 % 2

switch myRemainder {
case 1:
    print("it is 1")
case 2:
    print("it is 2")
case 3:
    print("it is 3")
case 3...50:
    print("it is between 3 and 50")
default:
    print("none of above")
}


//BREAKPOINTS
var a = 5
print(a)
a += 1
print(a)
