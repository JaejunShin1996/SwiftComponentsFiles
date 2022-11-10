//
//  ScrollViewReaderView.swift
//  CustomUIViews
//
//  Created by Jaejun Shin on 10/11/2022.
//

import SwiftUI

struct ScrollViewReaderView: View {
    @State private var searchIndex: Int = 0
    @State private var textfieldText = ""

    var body: some View {
        VStack {
            HStack {
                TextField("Search index…", text: $textfieldText)
                    .frame(height: 55)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .keyboardType(.numberPad)

                Button {
                    if let index = Int(textfieldText) {
                        searchIndex = index
                    }
                } label: {
                    Text("Search")
                        .padding()
                        .background(Color.white)
                        .foregroundColor(Color.black)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                }
            }
            .padding(.horizontal)
            .padding(.top)

            ScrollView {
                ScrollViewReader { proxy in
                    ForEach(0..<50) { index in
                        Text("This is index \(index)")
                            .font(.headline)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(radius: 10)
                            .padding()
                            .id(index)
                    }
                    .onChange(of: searchIndex) { newValue in
                        withAnimation(.spring()) {
                            proxy.scrollTo(newValue, anchor: .top)
                        }
                    }
                }
            }
        }
    }
}

struct ScrollViewReaderView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewReaderView()
    }
}
