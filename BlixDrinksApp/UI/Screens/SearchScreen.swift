//
//  SearchView.swift
//  BlixDrinksApp
//
//  Created by Festyk on 02/12/2024.
//

import SwiftUI

struct SearchScreen: View {
    @Binding var navigationState: NavigationStates
    
    @StateObject var viewModel = SearchViewModel()
    var body: some View {
        NavigationView {
            BackgroundedZStack {
                List(viewModel.drinks) { item in
                    if viewModel.state == .idle {
                        ScrollView{
                            NavigationLink {
                                CocktailDetailsScreen(cocktailId: item.id)
                                    .onAppear { navigationState = .details }
                            } label: {
                                CoctailListItemView(coctail: item)
                            }
                        }
                        .listRowBackground(Color.clear)
                    }
                    
                }.background(.clear)
                    .listStyle(.plain)
                    .searchable(text: $viewModel.enteredText,isPresented: $viewModel.focusSearch, placement: .navigationBarDrawer(displayMode: .always), prompt: "Start typing")
                    .toolbarBackground(.orange, for: .navigationBar)
                
                ProgressView()
                    .padding(30)
                    .background(.ultraThinMaterial.opacity(0.5))
                    .cornerRadius(15)
                    .opacity(viewModel.state == .loading ? 1.0 : 0.0)
                
                emptyResultsView
                errorView
            }
        }
        .navigationBarHidden(true)
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

#if DEBUG
struct SearchScreen_Previews : PreviewProvider {
    @State static var navigationState: NavigationStates = .search
    static var previews: some View {
        SearchScreen(navigationState: $navigationState)
    }
    
}
#endif

