//
//  AnimatableDataShapeExample.swift
//  AdvancedSwiftUI
//
//  Created by Jaejun Shin on 28/11/2022.
//

import SwiftUI

struct Pacman: Shape {
    var angle: Double

    var animatableData: Double {
        get { angle }
        set { angle = newValue }
    }

    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.height * 0.5,
                startAngle: Angle(degrees: angle),
                endAngle: Angle(degrees: 360 - angle),
                clockwise: false
            )
        }
    }
}

struct AnimatableDataShapeExample: View {
    @State private var animating: Bool = false

    var body: some View {
        ZStack {
            Pacman(angle: animating ? 20 : 0)
                .frame(width: 200, height: 200)
        }.onAppear {
            withAnimation(.easeInOut.repeatForever()) {
                animating.toggle()
            }
        }
    }
}

struct AnimatableDataShapeExample_Previews: PreviewProvider {
    static var previews: some View {
        AnimatableDataShapeExample()
    }
}
