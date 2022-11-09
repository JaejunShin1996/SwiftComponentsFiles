//
//  RotationGestureView.swift
//  CustomUIViews
//
//  Created by Jaejun Shin on 9/11/2022.
//

import SwiftUI

struct RotationGestureView: View {
    @State private var currentAngle: Angle = Angle(degrees: 0)

    var body: some View {
        Rectangle()
            .frame(height: 300)
            .background(.black)
            .rotationEffect(currentAngle)
            .gesture(
                RotationGesture()
                    .onChanged({ value in
                        currentAngle = value
                    })
                    .onEnded({ value in
                        withAnimation(.easeInOut) {
                            currentAngle = Angle(degrees: 0)
                        }
                    })
            )
    }
}

struct RotationGestureView_Previews: PreviewProvider {
    static var previews: some View {
        RotationGestureView()
    }
}
