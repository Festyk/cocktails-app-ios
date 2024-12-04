//
//  CocktailDetailsViewModel.swift
//  BlixDrinksApp
//
//  Created by Festyk on 03/12/2024.
//
import SwiftUI
import Combine
import Foundation

class CocktailDetailsViewModel: LoadableObject {
    @Published var cocktail: Cocktail?
    @Published private(set)var state: LoadingState = .idle
    
    private let cocktailsService: CocktailsService = RealCocktailsService()
    private var cancellables = Set<AnyCancellable>()
    
    func loadDrink(id: String) {
        self.state = .loading
        cocktailsService.getCocktailDetails(id: id)
            .sink {[weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.state = .failed
                case .finished:
                    self?.state = .idle
                }
            } receiveValue: { [weak self] cocktail in
                guard let cocktail = cocktail else {
                    return
                }
                self?.cocktail = cocktail
            }.store(in: &self.cancellables)
    }
}
