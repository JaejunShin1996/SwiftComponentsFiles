//
//  DragGesturePopUpView.swift
//  CustomUIViews
//
//  Created by Jaejun Shin on 9/11/2022.
//

import SwiftUI

struct DragGesturePopUpView: View {
    @State private var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.85
    @State private var currentDragOffsetY: CGFloat = .zero
    @State private var endingDragOffsetY: CGFloat = .zero

    var body: some View {
        ZStack {
            Color(.blue)
                .ignoresSafeArea()

            SignUpView()
                .offset(y: startingOffsetY)
                .offset(y: currentDragOffsetY)
                .offset(y: endingDragOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            currentDragOffsetY = value.translation.height
                        })
                        .onEnded({ value in
                            withAnimation(.spring()) {
                                if currentDragOffsetY < -150 {
                                    endingDragOffsetY = -startingOffsetY
                                } else if currentDragOffsetY > 150 {
                                    endingDragOffsetY = .zero
                                }
                                currentDragOffsetY = .zero
                            }
                        })
                )

            Text("\(currentDragOffsetY)")
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct DragGesturePopUpView_Previews: PreviewProvider {
    static var previews: some View {
        DragGesturePopUpView()
    }
}

struct SignUpView: View {
    var body: some View {
        VStack(spacing: 15) {
            Image(systemName: "chevron.up")
                .padding(.top)

            Text("Sign up")
                .font(.headline)
                .fontWeight(.semibold)

            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)

            Text("You would like to sign up to us so that you can explore more features you have which costs you absolutely nothing.")
                .multilineTextAlignment(.center)

            Button {

            } label: {
                Text("Sign up")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding()
                    .padding(.horizontal)
                    .background(Color.black.cornerRadius(10))
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.cornerRadius(30))
    }
}
