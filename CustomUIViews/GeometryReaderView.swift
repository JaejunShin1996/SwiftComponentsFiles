//
//  GeometryReaderView.swift
//  CustomUIViews
//
//  Created by Jaejun Shin on 10/11/2022.
//

import SwiftUI

struct GeometryReaderView: View {
    var body: some View {
        ScrollView(.vertical) {
            ForEach(0..<40) { index in
                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: 10)
                        .rotation3DEffect(
                            Angle(degrees: getPercentage(geo: geometry) * -30),
                            axis: (x: 1.0, y: 0.0, z: 0.0)
                        )
                }
                .frame(width: 200, height: 300)
                .padding(30)
            }
        }
    }

    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.height / 2
        let currentY = geo.frame(in: .global).midY
        return Double(1 - currentY / maxDistance)
    }
}

struct GeometryReaderView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderView()
    }
}
