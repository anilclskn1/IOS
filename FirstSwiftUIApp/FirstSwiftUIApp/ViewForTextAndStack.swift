//
//  ContentView.swift
//  FirstSwiftUIApp
//
//  Created by AnilyTugce on 5.10.2022.
//

import SwiftUI

struct ViewForTextAndStack: View {
    var body: some View {
        
        VStack {
            Text("My first project").bold()
            
            Text("Hello, world!")
                .font(.title)
                .foregroundColor(Color.orange)
                .bold()
                .padding()
        }
      
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ViewForTextAndStack()
    }
}
