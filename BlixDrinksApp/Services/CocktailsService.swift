//
//  CocktailsService.swift
//  BlixDrinksApp
//
//  Created by Festyk on 03/12/2024.
//
import Foundation
import Combine

protocol CocktailsService {
    var cocktailsRepository: CocktailsRepository { get }
    func searchCocktails(query: String) -> AnyPublisher<[Cocktail], Error>
    func getCocktailDetails(id: String) -> AnyPublisher<Cocktail?, Error>
}

struct RealCocktailsService: CocktailsService {
    var cocktailsRepository: any CocktailsRepository = WebCocktailsRepository()
    
    func searchCocktails(query: String) -> AnyPublisher<[Cocktail], any Error> {
        return cocktailsRepository.searchCocktails(query: query)
            .tryMap { response in
                return response.drinks ?? []
            }.eraseToAnyPublisher()
    }
    
    func getCocktailDetails(id: String) -> AnyPublisher<Cocktail?, any Error> {
        return cocktailsRepository.getCocktailDetails(id: id)
            .tryMap { response in
                return response.drinks?.first
            }.eraseToAnyPublisher()
    }
    
    
}
