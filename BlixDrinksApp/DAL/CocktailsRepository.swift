//
//  DrinksRepository.swift
//  BlixDrinksApp
//
//  Created by Festyk on 02/12/2024.
//
import Foundation
import Combine
import SwiftUI

protocol CocktailsRepository: WebRepository {
    func searchCocktails(query: String) -> AnyPublisher<CocktailsApiResponse, Error>
    func getCocktailDetails(id: String) -> AnyPublisher<CocktailsApiResponse, Error>
}

struct WebCocktailsRepository: CocktailsRepository {
    var baseURL = "https://www.thecocktaildb.com/api/json/v1/1/"
    func searchCocktails(query: String) -> AnyPublisher<CocktailsApiResponse, any Error> {
        return call(endpoint: API.searchCocktails(query))
    }
    
    func getCocktailDetails(id: String) -> AnyPublisher<CocktailsApiResponse, Error> {
        return call(endpoint: API.cocktailDetails(id))
    }
}

extension WebCocktailsRepository {
    enum API {
        case searchCocktails(String)
        case cocktailDetails(String)
    }
}

extension WebCocktailsRepository.API: APICall {
    var path: String {
        switch self {
        case .searchCocktails(let query):
            let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            return "search.php?s=\(encodedQuery ?? query)"
        case .cocktailDetails(let id):
            return "lookup.php?i=\(id)"
        }
    }
    var method: String {
        switch self {
        case .searchCocktails, .cocktailDetails:
            return "GET"
        }
    }
 
    func body() throws -> Data? {
        return nil
    }
}
