//
//  ViewForState.swift
//  FirstSwiftUIApp
//
//  Created by AnilyTugce on 5.10.2022.
//

import SwiftUI

struct ViewForButtonAndState: View {
    @State var myName = "Anil"
    
    var body: some View {
        VStack{
            Text(myName).bold().font(.largeTitle).padding()
            Button {
                self.myName = "James"
            } label: {
                Text("myButton")
            }
        }
    }
}

struct ViewForState_Previews: PreviewProvider {
    static var previews: some View {
        ViewForButtonAndState()
    }
}
