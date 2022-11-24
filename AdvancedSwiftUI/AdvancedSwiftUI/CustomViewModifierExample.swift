//
//  CustomViewModifierExample.swift
//  AdvancedSwiftUI
//
//  Created by Jaejun Shin on 24/11/2022.
//

import SwiftUI

struct TextViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .frame(height: 66)
            .frame(maxWidth: .infinity)
            .background(.blue)
            .cornerRadius(10.0)
            .shadow(radius: 10.0)
            .padding()
    }
}

extension View {
    func withDefaultTextViewFormatting() -> some View {
        modifier(TextViewModifier())
    }
}

struct CustomViewModifierExample: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .withDefaultTextViewFormatting()

            Text("Hello, world!")
                .withDefaultTextViewFormatting()

            Text("Hello, world!")
                .withDefaultTextViewFormatting()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CustomViewModifierExample()
    }
}
