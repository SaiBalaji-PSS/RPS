//
//  MainMenuView.swift
//  Challenge1RPS
//
//  Created by Sai Balaji on 31/12/25.
//

import SwiftUI

struct MainMenuView: View {
    @State var shouldNavigateToGameView: Bool = false
    var body: some View {
        NavigationStack{
            ZStack{
                Color("MainBackgroundColor")
                    .ignoresSafeArea()
                VStack(spacing: 20){
                    Text("RPS SCORE BATTLE")
                        .foregroundStyle(.white)
                        .font(.custom("SilkScreen", size: 48))
                        .multilineTextAlignment(.center)
                    NavigationLink(destination: GameView(), isActive: $shouldNavigateToGameView) {
                        EmptyView()
                    }
                    CustomButton(buttonTitle: "START") {
                        shouldNavigateToGameView.toggle()
                    }
                    CustomButton(buttonTitle: "PRACTICE") {
                        
                    }
                    CustomButton(buttonTitle: "LEADER BOARD") {
                        GameKitManager.shared.showLeaderBoards()
                    }
                    
                    
                }
            }
        }.onAppear {
            GameKitManager.shared.authenticate()
        }
       
    }
}

#Preview {
    MainMenuView()
}
