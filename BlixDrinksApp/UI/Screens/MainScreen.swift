//
//  MainScreen.swift
//  BlixDrinksApp
//
//  Created by Festyk on 03/12/2024.
//

import SwiftUI

struct MainScreen: View {
    @StateObject var viewModel = MainViewModel()
    var body: some View {
            BackgroundedZStack {
                switch viewModel.navigationState {
                case .welcome:
                    WelcomeScreen() {
                        withAnimation {
                            viewModel.navigationState = .search
                        }
                    }.transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
                case .search, .details:
                    SearchScreen(navigationState: $viewModel.navigationState).transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
                }
            }
    }
}

#Preview {
    MainScreen()
}
