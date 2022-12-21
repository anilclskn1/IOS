//
//  AddPlaceModel.swift
//  FourSquareClone
//
//  Created by AnilyTugce on 25.09.2022.
//

import Foundation
import UIKit

class AddPlaceModel {
    static let sharedInstance = AddPlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeComment = ""
    var placeImage = UIImage()
    var latitude = ""
    var longitude = ""
    
    private init(){}
}
