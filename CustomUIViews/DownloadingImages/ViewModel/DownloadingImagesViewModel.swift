//
//  DownloadingImagesViewModel.swift
//  CustomUIViews
//
//  Created by Jaejun Shin on 22/11/2022.
//

import Combine
import Foundation

class DownloadingImagesViewModel: ObservableObject {
    @Published var photos: [PhotoModel] = []

    let dataService = PhotoModelDataService.instance
    var cancellable = Set<AnyCancellable>()

    init() {
        addSubscribers()
    }

    func addSubscribers() {
        dataService.$photoModels
            .sink { [weak self] (returnedPhotoModels) in
                self?.photos = returnedPhotoModels
            }
            .store(in: &cancellable)
    }
}
