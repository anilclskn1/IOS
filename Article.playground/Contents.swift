import UIKit

var sentences = [String]()

sentences.append("Your future seems")
sentences.append("You will be hired in")



var firstArray = [String]()

firstArray.append("Amazing")
firstArray.append("Ambitious")
firstArray.append("Dark")
firstArray.append("Boring")


var secondArray = [String]()

secondArray.append("3 months")
secondArray.append("4 days")
secondArray.append("2 years")
secondArray.append("2 weeks")

let eFloat : Float = 2.7182818284
print(eFloat)

var cards = [String]()

cards.append("Tree")
cards.append("Sky")
cards.append("Sea")
cards.append("Forest")
cards.append("Village")
cards.append("Star")
cards.append("Universe")
cards.append("Mercury")

let firstRandomCardInt = Int.random(in: 0..<7)
let secondRandomCardInt = Int.random(in: 0..<7)

let firstRandomWordInt = Int.random(in: 0..<3)
let secondRandomWordInt = Int.random(in: 0..<3)

print("First card selected by the user : \(cards[firstRandomCardInt])")
print("Second card selected by the user : \(cards[secondRandomCardInt])")

print("First array word : \(firstArray[firstRandomWordInt])")
print("Second array word : \(secondArray[secondRandomWordInt])")

print("\(sentences[0]) Amazing")
print("\(sentences[1]) 4 days")
