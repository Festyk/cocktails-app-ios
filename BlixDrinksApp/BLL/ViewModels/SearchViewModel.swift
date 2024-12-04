//
//  SearchViewModel.swift
//  BlixDrinksApp
//
//  Created by Festyk on 02/12/2024.
//
import Foundation
import SwiftUI
import Combine

final class SearchViewModel: LoadableObject {
    @Published private(set)var state: LoadingState = .idle
    @Published private(set) var drinks: [Cocktail] = [Cocktail]()
    @Published var enteredText = ""
    @Published var focusSearch = false
    
    private let cocktailsService: CocktailsService = RealCocktailsService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        subscribeForTextChanges()
    }
    
    func loadDrinks(query: String) {
        cocktailsService.searchCocktails(query: query)
            .receive(on: DispatchQueue.main)
            .sink {[weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.state = .failed
                    print(error.localizedDescription)
                case .finished:
                    print("Success")
                }
            } receiveValue: { [weak self] list in
                self?.drinks = list
                self?.state = self?.drinks.count == 0 ? .empty : .idle
            }.store(in: &self.cancellables)
    }
    
    private func subscribeForTextChanges() {
        $enteredText
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] text in
                if text.isEmpty {
                    self?.focusSearch = true
                    self?.drinks.removeAll()
                }
                self?.state = text.count > 0 ? .loading : .idle
            }
            .store(in: &cancellables)
        
        $enteredText
            .receive(on: DispatchQueue.global())
            .debounce(for: .seconds(1.0), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] value in
                if value.count == 0 {
                    return
                }
                self?.drinks.removeAll()
                self?.loadDrinks(query: value)
            }.store(in: &cancellables)
    }
    
}
