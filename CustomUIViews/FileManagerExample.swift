//
//  FileManagerExample.swift
//  CustomUIViews
//
//  Created by Jaejun Shin on 18/11/2022.
//

import SwiftUI

class LocalFileManager {
    static let instance = LocalFileManager()

    init() {
        createFolder()
    }

    func createFolder() {
        guard let path =
                FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("Myapp_images").path() else {
            return
        }

        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true)
                print("Successful creating directory")
            } catch {
                print("error creating directory")
            }
        }
    }

    func deleteFolder() {
        guard let path =
                FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("Myapp_images").path() else {
            return
        }

        if FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.removeItem(atPath: path)
                print("Deleting directory")
            } catch {
                print("error deleting directory")
            }
        }
    }

    func getPathForImage(name: String) -> URL? {
        guard let path =
                FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("\(name)", conformingTo: .jpeg) else {
            print("Error getting path.")
            return nil
        }

        return path
    }

    func saveImages(image: UIImage, name: String) {
        guard let data = image.jpegData(compressionQuality: 1.0),
              let path = getPathForImage(name: name) else {
            print("Error getting data.")
            return
        }

        do {
            try data.write(to: path)
            print("success saving")
        } catch let error {
            print("\(error) error writing to path")
        }
    }

    func getImage(name: String) -> UIImage? {
        guard
            let path = getPathForImage(name: name)?.path(),
            FileManager.default.fileExists(atPath: path) else {
            return nil
        }

        return UIImage(contentsOfFile: path)
    }

    func deleteImageFromFM(name: String) {
        guard let path = getPathForImage(name: name)?.path(),
              FileManager.default.fileExists(atPath: path) else {
            return
        }

        do {
            try FileManager.default.removeItem(atPath: path)
        } catch let error {
            print("\(error) deleting image")
        }
    }
}

class FileManagerViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    let imageName: String = "TheGreenKnight"
    let manager = LocalFileManager.instance

    init() {
        getImageFromAssetsFolder()
//        getImageFromFileManager()
    }

    func getImageFromAssetsFolder() {
        image = UIImage(named: imageName)
    }

    func getImageFromFileManager() {
        image = manager.getImage(name: imageName)
    }

    func saveImage() {
        if let image = image {
            manager.saveImages(image: image, name: imageName)
        }
        manager.createFolder()
    }

    func deleteImageFromFM() {
        manager.deleteImageFromFM(name: imageName)
        manager.deleteFolder()
    }
}

struct FileManagerExample: View {
    @StateObject var vm = FileManagerViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)

                }

                HStack {
                    Button {
                        vm.saveImage()
                    } label: {
                        Text("Save to FM")
                            .foregroundColor(.white)
                            .padding()
                            .padding(.horizontal)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }

                    Button {
                        vm.deleteImageFromFM()
                    } label: {
                        Text("Delete from FM")
                            .foregroundColor(.white)
                            .padding()
                            .padding(.horizontal)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                }



                Spacer()
            }
            .navigationTitle("The Green Knight")
        }
    }
}

struct FileManagerExample_Previews: PreviewProvider {
    static var previews: some View {
        FileManagerExample()
    }
}
