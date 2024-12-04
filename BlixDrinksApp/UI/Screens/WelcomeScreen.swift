//
//  WelcomeScreen.swift
//  BlixDrinksApp
//
//  Created by Festyk on 03/12/2024.
//

import SwiftUI

struct WelcomeScreen: View {
    var closure: () -> Void
    
    var body: some View {
        VStack(spacing: 80) {
            Text("Cocktail app")
                .font(.system(size: 50))
                .fontWeight(.bold)
                .foregroundStyle(.white)
            ZStack {
                Circle()
                    .fill(
                        RadialGradient(colors: [  Color( #colorLiteral(red: 0.7786354296, green: 0.7756949258, blue: 0.04117351623, alpha: 1)), Color( #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1))]
                                       , center: .center,
                                       startRadius: 0,
                                       endRadius: 100)
                    )
                    .frame(width: 150, height: 150)
                    .shadow(radius: 20)
                Text("🍹")
                    .font(.system(size: 80))
            }
            
            Button{
                closure()
            } label: {
                Text("START")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 20)
                    .background(Color( #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)))
                    .cornerRadius(20)
                    .shadow(radius: 20)
            }
        }
    }
}

#if DEBUG
struct WelcomeScreen_Previews : PreviewProvider {
    static var previews: some View {
        WelcomeScreen() {}
    }

}
#endif

