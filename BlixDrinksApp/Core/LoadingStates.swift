//
//  LoadingStates.swift
//  BlixDrinksApp
//
//  Created by Festyk on 03/12/2024.
//

enum LoadingState: Equatable {
    static func == (lhs: LoadingState, rhs: LoadingState) -> Bool {
           lhs.value == rhs.value
       }
       
       var value: String? {
           return String(describing: self).components(separatedBy: "(").first
       }
    
    case idle
    case loading
    case empty
    case failed
   
}
