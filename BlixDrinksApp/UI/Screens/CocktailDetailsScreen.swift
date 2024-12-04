//
//  CocktailDetailsScreen.swift
//  BlixDrinksApp
//
//  Created by Festyk on 03/12/2024.
//

import SwiftUI

struct CocktailDetailsScreen: View {
    @StateObject var viewModel = CocktailDetailsViewModel()
    var cocktailId: String
    
    var body: some View {
      
        BackgroundedZStack {
            
            ScrollView {
                VStack (alignment: .leading, spacing: 15) {
                    image
                    
                    Text(viewModel.cocktail?.name ?? "Unnamed")
                        .font(.largeTitle)
                        .padding(.horizontal, 30)
                        .multilineTextAlignment(.leading)
                        .frame(alignment: .leading)
                    Text(viewModel.cocktail?.alcoholic ?? "")
                        .font(.headline)
                        .padding(.horizontal, 30)
                        .multilineTextAlignment(.leading)
                        .frame(alignment: .leading)
                    Text("Glass: " + (viewModel.cocktail?.glass ?? ""))
                        .font(.headline)
                        .padding(.horizontal, 30)
                        .multilineTextAlignment(.leading)
                        .frame(alignment: .leading)
                    Text(viewModel.cocktail?.instructions ?? "")
                        .font(.headline)
                        .padding(.horizontal, 30)
                        .multilineTextAlignment(.leading)
                        .frame(alignment: .leading)
                    
                    Text("Ingredients:")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.horizontal, 30)
                        .multilineTextAlignment(.leading)
                        .frame(alignment: .leading)
                    
                    if let ingredients = viewModel.cocktail?.ingredientsWithMeasure {
                        VStack (alignment: .leading, spacing: 5) {
                            ForEach(ingredients, id: \.0) { pair in
                                Text("\(pair.0) : \(pair.1)")
                                    .font(.headline)
                                    .padding(.horizontal, 30)
                                    .multilineTextAlignment(.leading)
                                    .frame(alignment: .leading)
                            }
                        }
                    }
                    Spacer()
                }
                .opacity(viewModel.state == .idle ? 1.0 : 0.0)
            }
            .toolbarBackground(.orange, for: .navigationBar)
            .foregroundStyle(.white)
            
            ProgressView()
                .padding(30)
                .background(.ultraThinMaterial.opacity(0.5))
                .cornerRadius(15)
                .opacity(viewModel.state == .loading ? 1.0 : 0.0)
            
            emptyResultsView
            errorView
        }.onAppear {
            viewModel.loadDrink(id: cocktailId)
        }
    }
    
    private var image: some View {
        AsyncImage(url: URL(string: viewModel.cocktail?.thumbnailUrl ?? ""), content: { image in
            image.resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width)
            
        }, placeholder: {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 30)
                .foregroundStyle(.white)
                .frame(width: UIScreen.main.bounds.width)
        })
    }
    
    private var emptyResultsView: some View {
        return Text("No results...")
            .font(.headline)
            .foregroundStyle(.white)
            .opacity(viewModel.state == .empty ? 1.0 : 0.0)
    }
    
    private var errorView: some View {
        return Text("Something went wrong")
            .font(.headline)
            .opacity(viewModel.state == .failed ? 1.0 : 0.0)
            .foregroundStyle(.white)
    }
    
}

#Preview {
    CocktailDetailsScreen(cocktailId: "13196")
}
