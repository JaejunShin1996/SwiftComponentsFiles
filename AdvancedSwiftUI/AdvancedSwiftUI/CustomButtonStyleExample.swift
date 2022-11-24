//
//  CustomButtonStyleExample.swift
//  AdvancedSwiftUI
//
//  Created by Jaejun Shin on 24/11/2022.
//

import SwiftUI

struct PressableButtonStyle: ButtonStyle {
    let scaleAmount: CGFloat

    init(scaleAmount: CGFloat) {
        self.scaleAmount = scaleAmount
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaleAmount : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}

extension View {
    func withScalableButtonStyle(scaleAmount: CGFloat = 0.9) -> some View {
        buttonStyle(PressableButtonStyle(scaleAmount: scaleAmount))
    }
}

struct CustomButtonStyleExample: View {
    var body: some View {
        Button {

        } label: {
            Text("Button style")
                .foregroundColor(.white)
                .withDefaultTextViewFormatting()
        }
        .withScalableButtonStyle(scaleAmount: 0.7)
    }
}

struct CustomButtonStyleExample_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtonStyleExample()
    }
}
