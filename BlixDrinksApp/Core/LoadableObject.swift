//
//  LoadableObject.swift
//  BlixDrinksApp
//
//  Created by Festyk on 03/12/2024.
//
import SwiftUI

protocol LoadableObject: ObservableObject {  
    var state: LoadingState{ get }
}
