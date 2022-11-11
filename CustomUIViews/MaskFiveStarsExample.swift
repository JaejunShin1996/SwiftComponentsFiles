//
//  MaskFiveStarsExample.swift
//  CustomUIViews
//
//  Created by Jaejun Shin on 11/11/2022.
//

import SwiftUI

struct MaskFiveStarsExample: View {
    @State private var rating = 2

    var body: some View {
        ZStack {
            StarsView
                .overlay {
                    OverlayView
                        .mask(StarsView)
                }
        }
    }

    var OverlayView: some View {
        GeometryReader { geometry in
            Rectangle()
                .foregroundColor(.yellow)
                .frame(width: CGFloat(rating) / 5 * geometry.size.width)
        }
        .allowsHitTesting(false)
    }

    var StarsView: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .foregroundColor(Color.gray)
                    .font(.largeTitle)
                    .onTapGesture {
                        withAnimation(.easeOut) {
                            rating = index
                        }
                    }
            }
        }
    }
}

struct MaskFiveStarsExample_Previews: PreviewProvider {
    static var previews: some View {
        MaskFiveStarsExample()
    }
}
