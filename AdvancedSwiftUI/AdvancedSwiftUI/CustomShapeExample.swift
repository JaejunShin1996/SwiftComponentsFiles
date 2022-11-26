//
//  CustomShapeExample.swift
//  AdvancedSwiftUI
//
//  Created by Jaejun Shin on 26/11/2022.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let horizontalWidthOffset = rect.width * 0.2
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - horizontalWidthOffset, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + horizontalWidthOffset, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}

struct Trapezoid: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let horizontalWidthOffset = rect.width * 0.2
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - horizontalWidthOffset, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + horizontalWidthOffset, y: rect.minY))
        }
    }
}

struct CustomShapeExample: View {
    var body: some View {
        ZStack {
            Trapezoid()
                .frame(width: 300, height: 300)
        }
    }
}

struct CustomShapeExample_Previews: PreviewProvider {
    static var previews: some View {
        CustomShapeExample()
    }
}
