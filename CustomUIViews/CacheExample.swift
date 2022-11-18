//
//  CacheExample.swift
//  CustomUIViews
//
//  Created by Jaejun Shin on 18/11/2022.
//

import SwiftUI

class CacheManager {
    static let instance = CacheManager()
    private init() { }

    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100
        return cache
    }()

    func add(image: UIImage, name: String) -> String {
        imageCache.setObject(image, forKey: name as NSString)
        return "Saved it to Cache"
    }

    func delete(name: String) -> String {
        imageCache.removeObject(forKey: name as NSString)
        return "Deleted it from cache"
    }

    func get(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
}

class ViewModel: ObservableObject {
    @Published var image: UIImage?
    var imageName = "TheGreenKnight"
    var manager = CacheManager.instance
    @Published var cachedIamge: UIImage?
    @Published var infoMessage: String = ""

    init() {
        getImageFromAssetsFolder(name: imageName)
    }

    func getImageFromAssetsFolder(name: String) {
        image = UIImage(named: name)
    }

    func saveToCache() {
        if let image = image {
            infoMessage = manager.add(image: image, name: imageName)
        }
    }

    func deleteFromCache() {
        infoMessage = manager.delete(name: imageName)
    }

    func getFromCache() {
        if let image = manager.get(name: imageName) {
            cachedIamge = image
            infoMessage = "Got it from cache"
        } else {
            infoMessage = "Nothing in cache"
        }
    }
}

struct CacheExample: View {
    @StateObject var vm = ViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .cornerRadius(20)
                        .clipped()
                }

                Text(vm.infoMessage)
                    .font(.title)

                HStack {
                    Button {
                        vm.saveToCache()
                    } label: {
                        Text("Save to Cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .padding(.horizontal)
                            .background(Color.blue)
                            .cornerRadius(20)
                    }

                    Button {
                        vm.deleteFromCache()
                    } label: {
                        Text("Delete from Cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .padding(.horizontal)
                            .background(Color.red)
                            .cornerRadius(20)
                    }
                }

                Button {
                    vm.getFromCache()
                } label: {
                    Text("Get from Cache")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.green)
                        .cornerRadius(20)
                }

                if let image = vm.cachedIamge {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .cornerRadius(20)
                        .clipped()
                }

                Spacer()
            }
            .navigationTitle("Cache")
        }
    }
}

struct CacheExample_Previews: PreviewProvider {
    static var previews: some View {
        CacheExample()
    }
}
