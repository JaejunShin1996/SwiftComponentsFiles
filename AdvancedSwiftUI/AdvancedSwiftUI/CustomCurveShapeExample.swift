//
//  CustomCurveShapeExample.swift
//  AdvancedSwiftUI
//
//  Created by Jaejun Shin on 26/11/2022.
//

import SwiftUI

struct KoreaCircle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.midY),
                control: CGPoint(x: rect.width * 0.25, y: rect.height * 0.75)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX, y: rect.midY),
                control: CGPoint(x: rect.width * 0.75, y: rect.height * 0.25)
            )
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: 100,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 180),
                clockwise: false
            )
        }
    }
}

struct CustomCurveShapeExample: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(.red)
                .frame(width: 200, height: 200)

            KoreaCircle()
                .fill(Color(.blue))
                .frame(width: 200, height: 200)
        }
    }
}

struct CustomCurveShapeExample_Previews: PreviewProvider {
    static var previews: some View {
        CustomCurveShapeExample()
    }
}
