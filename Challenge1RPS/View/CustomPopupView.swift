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
            Color(.black.opacity(0.45))
                .ignoresSafeArea()
            VStack(alignment:.center,spacing:8){
                Text(title)
                    .font(.largeTitle)
                    .bold()
                Text(message)
                    .font(.title)
                    .multilineTextAlignment(.center)
                HStack{
                    Button {
                        self.shouldDisplayAlert.toggle()
                        leftBtnClicked()
                    } label: {
                        Text("PLAY AGAIN")
                            .bold()
                            .foregroundStyle(.white)
                            .padding()
                   
                            .background(.pink)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    Button {
                        rightBtnClicked()
                    } label: {
                        Text("MAIN MENU")
                            .bold()
                            .foregroundStyle(.white)
                            .padding()
                            .background(.cyan)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }

                    
                    
                }.padding(.horizontal)
                
            }.padding().background(.white).padding()
        }
    }
}

#Preview {
    CustomPopupView(shouldDisplayAlert: .constant(true),title: "YOU WIN !",message: "YOUR SCORE IS 5") {
        
    } rightBtnClicked: {
        
    }
}
