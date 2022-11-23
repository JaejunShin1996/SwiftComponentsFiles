//
//  PhotoModelFileManager.swift
//  CustomUIViews
//
//  Created by Jaejun Shin on 23/11/2022.
//

import Foundation
import SwiftUI

class PhotoModelFileManager {
    static let instance = PhotoModelFileManager()
    let folderName = "downloaded_photos"
    private init() {
        createPathIfNeeded()
    }

    private func createPathIfNeeded() {
        guard let url = getFolderPath() else { return }

        if !FileManager.default.fileExists(atPath: url.path()) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
                print("Created new Directory")
            } catch let error {
                print("error getting directory \(error.localizedDescription)")
            }
        }
    }

    private func getFolderPath() -> URL? {
        return FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
    }

    private func getImagePath(key: String) -> URL? {
        guard let folderUrl = getFolderPath() else { return nil }

        return folderUrl.appendingPathComponent(key, conformingTo: .png)
    }

    func add(key: String, value: UIImage) {
        guard let data = value.pngData(), let url = getImagePath(key: key) else { return }

        do {
            try data.write(to: url)
            print("Success saving imgs to filemanager")
        } catch let error {
            print("error adding image, \(error.localizedDescription)")
        }
    }

    func get(key: String) -> UIImage? {
        guard let url = getImagePath(key: key), FileManager.default.fileExists(atPath: url.path()) else { return nil }

        return UIImage(contentsOfFile: url.path())
    }
}
