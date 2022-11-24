//
//  AnyTransitionExample.swift
//  AdvancedSwiftUI
//
//  Created by Jaejun Shin on 24/11/2022.
//

import SwiftUI

struct RotateAnyTransition: ViewModifier {
    let rotationAmount: Double

    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: rotationAmount))
            .offset(x: rotationAmount != 0 ? UIScreen.main.bounds.width : 0,
                    y: rotationAmount != 0 ? UIScreen.main.bounds.height : 0)
    }
}

extension AnyTransition {
    static var rotating: AnyTransition {
        return AnyTransition.modifier(
            active: RotateAnyTransition(rotationAmount: 180),
            identity: RotateAnyTransition(rotationAmount: 0)
        )
    }

    static func rotating(rotationAmount: Double) -> AnyTransition {
        return AnyTransition.modifier(
            active: RotateAnyTransition(rotationAmount: rotationAmount),
            identity: RotateAnyTransition(rotationAmount: 0)
        )
    }

    static var rotateOn: AnyTransition {
        return AnyTransition.asymmetric(
            insertion: .rotating,
            removal: .move(edge: .leading)
        )
    }
}

struct AnyTransitionExample: View {
    @State private var showingRect = false

    var body: some View {
        VStack {
            Spacer()

            if showingRect {
                RoundedRectangle(cornerRadius: 14.0)
                    .frame(width: 250, height: 250)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.rotateOn)
            }

            Spacer()

            Button {
                withAnimation(.spring()) {
                    showingRect.toggle()
                }
            } label: {
                Text("Click Me")
                    .foregroundColor(.white)
                    .withDefaultTextViewFormatting()
            }

        }
    }
}

struct AnyTransitionExample_Previews: PreviewProvider {
    static var previews: some View {
        AnyTransitionExample()
    }
}
