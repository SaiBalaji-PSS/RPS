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
        case rock = "ROCK 1"
        case paper = "PAPER 1"
        case scissor = "SCISSOR 1"
    }
    
    @ObservationIgnored
    let images: [InputStates] = [.rock,.paper,.scissor]
    @ObservationIgnored
    let conditions: [GameCondition] = [.win,.loose]
    
    var selectedQuestion: InputStates = .rock
    var selectedCondition: GameCondition = .win
    
    var currentStreak = 0
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
    
   
    
  
    
   
    
    func startTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
           
            print("TIMER PRINTING \(self.timerCountValue)")
            if self.timerCountValue <= 0{
                print("TIME OUT HANDLE GAME OVER")
                self.handleGameOver()
                
            }
            else{
                self.timerCountValue -= 1.0
            }
        })
    }
    
    func stopTimer(){
        self.timerCountValue = self.totalTimerValue
        timer?.invalidate()
        timer = nil
    }
    
    func askNextQuestion(){
        print("CURRENT SCORE IS \(currentScore)")
        selectedQuestion = images.randomElement() ?? .rock
        selectedCondition = conditions.randomElement() ?? .win
        self.stopTimer()
        self.startTimer()
    }
    
    
    func handleGameOver(){
        self.showAlert = true
        self.message = "SCORE - \(currentScore) \n STREAK - \(currentStreak) \n TOTAL SCORE - \(currentScore * currentStreak)"
        self.resetGame()
    }
    
    func resetGame(){
        selectedQuestion = images.randomElement() ?? .rock
        selectedCondition = conditions.randomElement() ?? .win
        currentScore = 0
        currentStreak = 0
        self.timerCountValue = self.totalTimerValue
        self.stopTimer()
    }
    
    func validateUserInput(input: InputStates){
        if selectedQuestion == .rock{
            if selectedCondition == .win{
                if input == .paper{
                    currentStreak += 1
                    currentScore += 1
                  
                }
                else{
                    currentStreak = 0
                }
            }
            else{
                if input == .scissor{
                    currentStreak += 1
                    currentScore += 1
                   
                }
                else{
                    currentStreak  = 0
                }
            }
        }
        else if selectedQuestion == .paper{
            if selectedCondition == .win{
                if input == .scissor{
                    currentStreak = 1
                    currentScore += 1
                   
                }
                else{
                    currentStreak = 0
                }
            }
            else{
                if input == .rock{
                    currentStreak += 1
                    currentScore += 1
                   
                }
                else{
                    currentStreak = 0
                }
            }
        }
        else if selectedQuestion == .scissor{
            if selectedCondition == .win{
                if input == .rock{
                    currentStreak += 1
                    currentScore += 1
                   
                }
                else{
                    currentStreak  = 0
                }
            }
            else{
                if input == .paper{
                    currentStreak += 1
                    currentScore += 1
                   
                }
                else{
                    currentStreak = 0
                }
            }
        }
        
        self.askNextQuestion()
    }
    
}
