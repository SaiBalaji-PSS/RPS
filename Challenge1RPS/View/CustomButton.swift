//
//  CustomButton.swift
//  Challenge1RPS
//
//  Created by Sai Balaji on 31/12/25.
//

import SwiftUI

struct CustomButton: View {
    let buttonTitle: String
    var buttonClicked: () -> (Void)
    var body: some View {
        Button {
            buttonClicked()
        } label: {
            Text(buttonTitle)
                .font(.custom("Silkscreen", size: 24.0))
                .foregroundStyle(.white)
                .padding()
                .background(.black)
        }

    }
}

#Preview {
    CustomButton(buttonTitle: "Click") {
        
    }
}
