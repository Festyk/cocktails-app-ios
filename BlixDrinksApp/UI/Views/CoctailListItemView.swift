//
//  CoctailListItemView.swift
//  BlixDrinksApp
//
//  Created by Festyk on 03/12/2024.
//

import SwiftUI

struct CoctailListItemView: View {
    var coctail: Cocktail
    var body: some View {
        HStack (spacing: 20) {
            Thumbnail(url: URL(string: coctail.thumbnailUrl ?? ""))
            VStack (alignment: .leading) {
                Text(coctail.name ?? "Unnamed")
                    .font(.largeTitle)
                Text(coctail.alcoholic ?? "")
                    .font(.headline)
                Text(coctail.glass ?? "")
                    .font(.subheadline)
                Text("Ingredients: " + (coctail.ingredientsWithMeasure?.count.description ?? "0"))
                    .font(.subheadline)
                Spacer()
            }
            Spacer()
        }.frame(maxWidth: .infinity)
            .frame(height: 150)
            .foregroundStyle(.white)
            .padding()
            .background(.orange)
            .cornerRadius(20)
    }
}

struct Thumbnail: View {
    var url: URL?
    
    var body: some View {
        AsyncImage(url: url, content: { image in
            image.resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .cornerRadius(50)
                
        }, placeholder: {
            Image(systemName: "photo")
                .resizable()
                .foregroundStyle(.white)
                .scaledToFit()
                .frame(width: 100, height: 100)
        })
    }
}

#Preview {
    Thumbnail()
}

#Preview {
    CoctailListItemView(coctail: Cocktail(id: "16967", name: "Vodka Fizz", category: "Other / Unknown", alcoholic: "Alcoholic", glass: "White wine glass", instructions: "Blend all ingredients, save nutmeg. Pour into large white wine glass and sprinkle nutmeg on top.", thumbnailUrl: "https://www.thecocktaildb.com/images/media/drink/xwxyux1441254243.jpg"))
}
