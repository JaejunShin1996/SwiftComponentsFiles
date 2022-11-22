//
//  PhotoModelDataService.swift
//  CustomUIViews
//
//  Created by Jaejun Shin on 22/11/2022.
//

import Combine
import Foundation

class PhotoModelDataService {
    static let instance = PhotoModelDataService()

    @Published var photoModels: [PhotoModel] = []
    var cancellable = Set<AnyCancellable>()

    private init() {
        downloadData()
    }

    func downloadData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    print("success")
                    break
                case .failure(let error):
                    print("Error downloading: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] (returnedPhotoModels) in
                self?.photoModels = returnedPhotoModels
            }
            .store(in: &cancellable)

    }

    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }

        return output.data
    }
}
