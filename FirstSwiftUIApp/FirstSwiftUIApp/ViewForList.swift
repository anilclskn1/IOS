//
//  ViewForList.swift
//  FirstSwiftUIApp
//
//  Created by AnilyTugce on 5.10.2022.
//

import SwiftUI

struct ViewForList: View {
    
    let myArray = ["Anıl","Kerem","Tuğçe","Ertuğrul"]
    
    var body: some View {
     /*   List(myArray, id: \.self) { element in
            Image("anil").resizable().aspectRatio(contentMode: .fit).frame(width: 30, height: 30)
            Text(element)
        }*/
        
        List {
            ForEach(myArray, id: \.self) {element in
                Text(element)
            }
        }
    }
}

struct ViewForList_Previews: PreviewProvider {
    static var previews: some View {
        ViewForList()
    }
}
