//
//  GameKitManager.swift
//  Challenge1RPS
//
//  Created by Sai Balaji on 31/12/25.
//

import Foundation
import UIKit
import GameKit

final class GameKitManager: NSObject{
    
    static let leaderBoardId = "com.saibalajik.RPSChallenge.HighScore"
    
    static let shared = GameKitManager()
    
    private override init() {
        
    }
    
    func authenticate(){
        GKLocalPlayer.local.authenticateHandler = { [weak self] viewController, error in
            if let viewController = viewController{
                self?.present(viewController: viewController)
                return
            }
            if let error = error{
                print("Game Center Auth error \(error.localizedDescription)")
            }
            if GKLocalPlayer.local.isAuthenticated{
                GKAccessPoint.shared.location = .topTrailing
                GKAccessPoint.shared.isActive = true
                print("PLAYER AUTHENTICATED AS \(GKLocalPlayer.local.displayName)")
            }
            else{
                print("GAME CENTER PLAYER IS NOT AUTHENTICATED")
            }
        }
    }
    
    func present(viewController: UIViewController){
        guard let root = UIApplication.shared.connectedScenes.compactMap({$0 as? UIWindowScene}).flatMap({$0.windows}).first(where: {$0.isKeyWindow})?.rootViewController else{return }
        var top = root
        while let presented = top.presentedViewController{
            top = presented
        }
        top.present(viewController, animated: true)
    }
    
    
    func showLeaderBoards(){
        guard  GKLocalPlayer.local.isAuthenticated else{
            authenticate()
            return }
        GKAccessPoint.shared.isActive = true
        if GKAccessPoint.shared.isActive{
            //trigger leader board
            GKAccessPoint.shared.trigger(state: .leaderboards) {
                
            }
        }
        
    }
    
    func submitScore(score: Int){
        guard GKLocalPlayer.local.isAuthenticated else{
            authenticate()
            return
        }
        GKLeaderboard.submitScore(score, context: 0, player: GKLocalPlayer.local, leaderboardIDs: [GameKitManager.leaderBoardId]){ error in
            if let error{
                print("ERROR SUBMITTING SCORE \(error.localizedDescription)")
            }
            else{
                print("SCORE SUBMITTED TO LEADERBOARD:: \(score)")
            }
        }
    }
    
}
