//
//  DetailsView.swift
//  FavoriteBook
//
//  Created by AnilyTugce on 5.10.2022.
//

import SwiftUI

struct DetailsView: View {
    
    var chosenFavorite : FavoriteElements
    
    var body: some View {
        VStack {
            Image(chosenFavorite.imageName).resizable().aspectRatio(contentMode: .fit)
            Text(chosenFavorite.name).bold().font(.largeTitle)
            Text(chosenFavorite.description)
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(chosenFavorite: metallica)
    }
}
