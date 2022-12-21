//
//  main.swift
//  ClassesApp
//
//  Created by AnilyTugce on 4.09.2022.
//

import Foundation

var tugce = Friends(nameInit: "Tugce", ageInit: 23, jobInit: "Literature Teacher" , typeInit: .funny)
print(tugce.job)
tugce.tell()
print(tugce.type)

var eto = SuperFriends(nameInit: "Eto", ageInit: 26, jobInit: "Trades", typeInit: .reliable)
eto.tell()

