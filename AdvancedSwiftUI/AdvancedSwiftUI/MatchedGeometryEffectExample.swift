//
//  MatchedGeometryEffectExample.swift
//  AdvancedSwiftUI
//
//  Created by Jaejun Shin on 25/11/2022.
//

import SwiftUI

struct MatchedGeometryEffectExample2: View {
    let categories: [String] = ["Home", "Work", "Saved"]
    @State private var isSelected = "Home"
    @Namespace private var namespace

    var body: some View {
        HStack {
            ForEach(categories, id: \.self) { category in
                ZStack {
                    if category == isSelected {
                        RoundedRectangle(cornerRadius: 15.0)
                            .fill(Color.blue.opacity(0.5)).matchedGeometryEffect(id: "rectangle", in: namespace)
                            .frame(width: 50, height: 5)
                            .offset(y: 19)
                    }

                    Text(category)
                        .font(.title)
                        .foregroundColor(isSelected == category ? Color.blue.opacity(0.5) : Color.black)
                }
                .onTapGesture {
                    withAnimation(.default) {
                        isSelected = category
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
    }
}

struct MatchedGeometryEffectExample: View {
    @State private var isClicked = false
    @Namespace private var namespace
    var body: some View {
        VStack {
            if isClicked {
                RoundedRectangle(cornerRadius: 15)
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 150, height: 150)
            }

            Spacer()

            if !isClicked {
                RoundedRectangle(cornerRadius: 15)
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 300, height: 300)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blue)
        .onTapGesture {
            withAnimation(.default) {
                isClicked.toggle()
            }
        }
    }
}

struct MatchedGeometryEffectExample_Previews: PreviewProvider {
    static var previews: some View {
        MatchedGeometryEffectExample2()
    }
}
