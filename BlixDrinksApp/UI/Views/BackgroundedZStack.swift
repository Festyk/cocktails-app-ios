//
//  BackgroundedZStack.swift
//  BlixDrinksApp
//
//  Created by Festyk on 03/12/2024.
//

import SwiftUI

struct BackgroundedZStack<Content: View>: View {
    @ViewBuilder let content: Content
    
    var body: some View {
        ZStack {
            content
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                colors: [
                    Color( #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)),
                    Color( #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))],
                startPoint: .bottom,
                endPoint: .top)
        )
           
    }
    

}

#Preview {
    BackgroundedZStack {
       
    }
}
