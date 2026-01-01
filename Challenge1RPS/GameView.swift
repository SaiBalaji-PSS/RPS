//
//  ContentView.swift
//  Challenge1RPS
//
//  Created by Sai Balaji on 28/12/25.
//

import SwiftUI



enum GameMode{
    case scoreAttack
    case practice
}


struct GameView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var vm: GameViewModel = GameViewModel()
    
    var body: some View {
        
            GeometryReader { reader in
                ZStack{
                    Color("MainBackgroundColor")
                        .ignoresSafeArea()
                    VStack(spacing:40){
                        HStack{
                            CustomButton(buttonTitle: vm.isGamePaused ? "RESUME" : "PAUSE") {
                                self.vm.pauseGame()
                            }
                            Spacer()
                        }.padding(.horizontal)
                        ZStack(alignment: .center) {
                            CirrcularProgressView(progress: .constant(Double(vm.timerCountValue / vm.totalTimerValue)))
                                .frame(width: reader.size.width,height: 250)
                            Image(vm.selectedQuestion.rawValue.lowercased())
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150,height: reader.size.height / 4)
                                .padding(2)
                            
                        }.frame(maxWidth: .infinity)
                        
                        VStack(alignment:.center){
                            Text("\(vm.selectedCondition.rawValue.uppercased()) THE GAME!")
                                .foregroundStyle(.white)
                                .font(.custom("Silkscreen", size: 38.0))
                            
                            Divider()
                            HStack(spacing:10){
                                ForEach(vm.images,id: \.self){ imageName in
                                    Button {
                                        vm.validateUserInput(input: imageName)
                                    } label: {
                                        Image(imageName.rawValue.lowercased())
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: reader.size.width / 3.5,height: 150)
                                           
                                            .clipShape(RoundedRectangle(cornerRadius: 20.0))
                                            .overlay( RoundedRectangle(cornerRadius: 20.0).stroke(.white, lineWidth: 4.0))
                                            .shadow(radius: 2.0)
                                    }.sensoryFeedback(.success, trigger: vm.currentScore)
                                    
                                    
                                }
                            }
                        }
                    
                            VStack{
                                
                                Text("Streak: \(vm.currentStreak)")
                                    .font(.custom("Silkscreen", size: 30))
                                    .foregroundStyle(.white)
                                    .fontWeight(.medium)
                                Text("Score: \(vm.currentScore)")
                                    .font(.custom("Silkscreen", size: 30))
                                    .foregroundStyle(.white)
                                    .fontWeight(.medium)
                            }
                        

                        Spacer()
                    }.padding(.top)
                    if vm.showAlert{
                        CustomPopupView(shouldDisplayAlert: $vm.showAlert, title: vm.alertTitle, message: vm.message,leftBtnTitle:vm.leftBtnMessage,rightBtnTitle: vm.rightBtnMessage) {
                            //play agian // resume
                            if vm.leftBtnMessage == "RESUME"{
                                vm.resumeGame()
                            }
                            else if vm.leftBtnMessage == "PLAY AGAIN"{
                                vm.restartGame()
                                GameKitManager.shared.submitScore(score: vm.currentScore)
                            }
                           
                           
                        } rightBtnClicked: {
                            //main menu
                            vm.resetGame()
                            dismiss()
                        }
                    }
                }
                .navigationBarBackButtonHidden()
            }
           
           
            .navigationBarTitleDisplayMode(.inline)
        
        .onAppear {
            for family in UIFont.familyNames.sorted() {
                print("Family: \(family)")
                for name in UIFont.fontNames(forFamilyName: family) {
                    print(" - \(name)")
                }
            }
            vm.askNextQuestion()
        }
    }
    
}

#Preview {
    GameView()
}
