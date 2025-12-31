//
//  CirrcularProgressView.swift
//  Challenge1RPS
//
//  Created by Sai Balaji on 29/12/25.
//

import SwiftUI

struct CirrcularProgressView: View {
    @Binding var progress: Double
    var body: some View {
        ZStack{
            Circle()
                .stroke(Color.black,lineWidth: 20.0)
            Circle()
                .trim(from: 0,to: progress)
                .stroke(Color.white,lineWidth: 20.0)
                .rotationEffect(.degrees(270))
                .animation(.bouncy, value: progress)
        }
    }
}

#Preview {
    CirrcularProgressView(progress: .constant(0.25))
}
