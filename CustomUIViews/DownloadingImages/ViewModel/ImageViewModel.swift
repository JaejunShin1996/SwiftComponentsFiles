//
//  ImageViewModel.swift
//  CustomUIViews
//
//  Created by Jaejun Shin on 22/11/2022.
//

import Combine
import Foundation
import SwiftUI

class ImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading = false

    var cancellable = Set<AnyCancellable>()

    let url: String

    init(url: String) {
        self.url = url
        downloadImage()
    }

    func downloadImage() {
        isLoading = true
        guard let url = URL(string: url) else {
            isLoading = false
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map { data, response in
                UIImage(data: data)
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            }
            .store(in: &cancellable)

    }
}
