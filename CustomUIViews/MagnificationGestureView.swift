//
//  MagnificationGestureView.swift
//  CustomUIViews
//
//  Created by Jaejun Shin on 8/11/2022.
//

import SwiftUI

struct MagnificationGestureView: View {
    @State private var currentAmount: CGFloat = 0.0
    @State private var lastAmount: CGFloat = 0.0

    var body: some View {
        VStack {
            Rectangle()
                .frame(height: 300)
                .scaleEffect(1 + currentAmount)
                .gesture(
                    MagnificationGesture()
                        .onChanged { amount in
                            currentAmount = amount - 1
                        }
                        .onEnded { amount in
                            lastAmount += currentAmount
                            withAnimation(.spring()) {
                                currentAmount = 0
                            }
                        }
                )
        }
    }
}

struct MagnificationGestureView_Previews: PreviewProvider {
    static var previews: some View {
        MagnificationGestureView()
    }
}
