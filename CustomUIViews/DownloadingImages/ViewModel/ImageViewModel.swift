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

    //  stays alive on one cycle
    let cacheManager = PhotoModelCacheManager.instance
    //  stays permenantly on the app
    let fileManager = PhotoModelFileManager.instance
    var cancellable = Set<AnyCancellable>()

    let url: String
    let key: String

    init(url: String, key: String) {
        self.url = url
        self.key = key
        getImages()
    }

    func getImages() {
        if let savedImage = fileManager.get(key: key) {
            image = savedImage
            print("getting saved image")
        } else {
            downloadImage()
            print("downloaded images")
        }


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
                guard let self = self, let image = returnedImage else { return }
                self.image = image
                self.fileManager.add(key: self.key, value: image)
            }
            .store(in: &cancellable)

    }
}
