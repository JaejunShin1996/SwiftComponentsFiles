//
//  MultipleSheetsExample.swift
//  CustomUIViews
//
//  Created by Jaejun Shin on 10/11/2022.
//

import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID()
    let title: String
}

struct MultipleSheetsExample: View {
    @State private var randomModel = RandomModel(title: "None")
    @State private var showingNextView = false

    var body: some View {
        ScrollView {
            ForEach(0..<29) { index in
                Button {
                    showingNextView.toggle()
                    randomModel = RandomModel(title: "\(index)")
                } label: {
                    Text("\(index)")
                }
            }
        }
        .sheet(isPresented: $showingNextView) {
            RandomNextView(model: $randomModel)
        }
    }
}

struct RandomNextView: View {
    @Binding var model: RandomModel

    var body: some View {
        Text(model.title)
            .font(.title)
    }
}

struct MultipleSheetsExample_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetsExample()
    }
}
