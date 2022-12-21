//
//  SecondView.swift
//  FirstSwiftUIApp
//
//  Created by AnilyTugce on 5.10.2022.
//

import SwiftUI

struct ViewForImage: View {
    var body: some View {
        
        Image("anil")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.5)
        
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        ViewForImage()
    }
}
