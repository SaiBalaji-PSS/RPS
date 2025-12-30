//
//  ViewModel.swift
//  Challenge1RPS
//
//  Created by Sai Balaji on 29/12/25.
//

import Foundation

@Observable
class GameViewModel{
    enum GameCondition: String{
        case win = "WIN"
        case loose = "LOOSE"
    }
    enum InputStates: String{
        case rock = "ROCK"
        case paper = "PAPER"
        case scissor = "SCISSOR"
    }
    
    @ObservationIgnored
    let images: [InputStates] = [.rock,.paper,.scissor]
    @ObservationIgnored
    let conditions: [GameCondition] = [.win,.loose]
    
    var selectedQuestion: InputStates = .rock
    var selectedCondition: GameCondition = .win
    var currentScore = 0
    var showAlert: Bool = false
    @ObservationIgnored
    var message: String = ""
    
    @ObservationIgnored
    var totalTimerValue: Double = 5.0
    
    var timerCountValue: Double = 5.0
    
    @ObservationIgnored
    var timer: Timer?
    
    init(){
        timerCountValue = totalTimerValue
    }
    
    func resetGame(clearScore: Bool = false){
        selectedQuestion = images.randomElement() ?? .rock
        selectedCondition = conditions.randomElement() ?? .win
        if clearScore{
            currentScore = 0
        }
        else{
            self.stopTimer()
            self.startTimer()
        }
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
           
            print("TIMER PRINTING \(self.timerCountValue)")
            if self.timerCountValue <= 0{
                print("TIME OUT HANDLE GAME OVER")
                self.handleGameOver()
                
            }
            else{
                self.timerCountValue -= 1
            }
        })
    }
    
    func stopTimer(){
        self.timerCountValue = self.totalTimerValue
        timer?.invalidate()
        timer = nil
    }
    
    func handleGameOver(){
        self.timerCountValue = self.totalTimerValue
        self.stopTimer()
        self.showAlert = true
        self.message = "GAME OVER YOUR SCORE IS \(currentScore)"
        self.resetGame(clearScore: true)
        
        
    }
    
    func validateUserInput(input: InputStates){
        if selectedQuestion == .rock{
            if selectedCondition == .win{
                if input == .paper{
                    currentScore += 1
                }
                else{
                    currentScore -= 1
                }
            }
            else{
                if input == .scissor{
                    currentScore += 1
                }
                else{
                    currentScore  -= 1
                }
            }
        }
        else if selectedQuestion == .paper{
            if selectedCondition == .win{
                if input == .scissor{
                    currentScore += 1
                }
                else{
                    currentScore -= 1
                }
            }
            else{
                if input == .rock{
                    currentScore += 1
                }
                else{
                    currentScore -= 1
                }
            }
        }
        else if selectedQuestion == .scissor{
            if selectedCondition == .win{
                if input == .rock{
                    currentScore += 1
                }
                else{
                    currentScore -= 1
                }
            }
            else{
                if input == .paper{
                    currentScore += 1
                }
                else{
                    currentScore -= 1
                }
            }
        }
        if currentScore < 0{
            currentScore = 0
        }
        self.resetGame()
    }
    
}
