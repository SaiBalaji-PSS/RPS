//
//  CustomPopupView.swift
//  Challenge1RPS
//
//  Created by Sai Balaji on 30/12/25.
//

import SwiftUI

struct CustomPopupView: View {
    @Binding var shouldDisplayAlert: Bool
  
    let title: String
    let message: String
    var leftBtnClicked: () -> (Void)
    var rightBtnClicked: () -> (Void)
    var body: some View {
        ZStack{
            Color("FirstGradientColor")
                .ignoresSafeArea()
            VStack(alignment:.center,spacing:18){
                Text(title)
                    .foregroundStyle(.white)
                    .font(.custom("Silkscreen", size: 30))
                    .fontWeight(.light)
                
                Text(message)
                    .foregroundStyle(.white)
                    .font(.custom("Silkscreen", size: 24))
                    .multilineTextAlignment(.center)
                
                HStack{
                    Button {
                        self.shouldDisplayAlert.toggle()
                        leftBtnClicked()
                    } label: {
                        Text("PLAY AGAIN")
                            .font(.custom("Silkscreen", size: 18))
                            .fontWeight(.light)
                            .foregroundStyle(.white)
                            .padding()
                   
                            .background(.black)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    Divider()
                        .frame(width: 2)
                        .background(.white)
                    
                    Button {
                        rightBtnClicked()
                    } label: {
                        Text("MAIN MENU")
                            .font(.custom("Silkscreen", size: 18))
                            .foregroundStyle(.white)
                            .padding()
                            .background(.black)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }

                    
                    
                }.frame(height:50).border(.white)
                
            }.padding().background(Color("FirstGradientColor"))
        }
    }
}

#Preview {
    CustomPopupView(shouldDisplayAlert: .constant(true),title: "YOU WIN !",message: "SCORE - 5 \n STREAK - 10 \n TOTAL SCORE - 50") {
        
    } rightBtnClicked: {
        
    }
}
