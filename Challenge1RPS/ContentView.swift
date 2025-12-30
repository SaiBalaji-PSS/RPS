//
//  ContentView.swift
//  Challenge1RPS
//
//  Created by Sai Balaji on 28/12/25.
//

import SwiftUI





struct ContentView: View {
   
    @State var vm: GameViewModel = GameViewModel()
    
    var body: some View {
        NavigationStack{
            GeometryReader { reader in
                ZStack{
                    VStack(spacing:40){
                        
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
                                .font(.title)
                                .bold()
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
                                            .background(.yellow)
                                            .clipShape(RoundedRectangle(cornerRadius: 20.0))
                                            .overlay( RoundedRectangle(cornerRadius: 20.0).stroke(.black, lineWidth: 4.0))
                                            .shadow(radius: 2.0)
                                    }
                                    
                                    
                                }
                            }
                        }
                        if vm.currentScore != 0{
                            Text("Score: \(vm.currentScore)")
                                .font(.title3)
                                .fontWeight(.medium)
                        }
                        Button(action: {
                            vm.resetGame(clearScore: true)
                        }, label: {
                            Text("Rest Game")
                                .font(.title3)
                                .bold()
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(.green)
                                .foregroundStyle(.white)
                            
                                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                                .overlay(RoundedRectangle(cornerRadius: 10.0).stroke(.black,lineWidth: 4.0))
                                .padding(.horizontal)
                        })
                        Spacer()
                    }.padding(.top)
                    if vm.showAlert{
                        CustomPopupView(shouldDisplayAlert: $vm.showAlert, title: "TEST", message: vm.message) {
                            vm.resetGame()
                        } rightBtnClicked: {
                            
                        }
                    }
                }
            }
           
            .navigationTitle("Rock Paper Scissor")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            vm.resetGame()
        }
    }
    
}

#Preview {
    ContentView()
}
