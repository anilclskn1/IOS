//
//  ViewForBinding.swift
//  FirstSwiftUIApp
//
//  Created by AnilyTugce on 5.10.2022.
//

import SwiftUI

struct ViewForBinding: View {
    @State var text = "James"
    var body: some View {
        VStack {
            Text(text).padding().font(.largeTitle)
            TextField("placeholder", text: $text)
        }
    }
}

struct ViewForBinding_Previews: PreviewProvider {
    static var previews: some View {
        ViewForBinding()
    }
}
