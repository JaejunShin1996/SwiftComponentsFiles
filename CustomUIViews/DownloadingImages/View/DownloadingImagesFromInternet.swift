//
//  DownloadingImagesFromInternet.swift
//  CustomUIViews
//
//  Created by Jaejun Shin on 22/11/2022.
//

import SwiftUI

struct DownloadingImagesFromInternet: View {
    @StateObject var vm = DownloadingImagesViewModel()

    var body: some View {
        NavigationView {
            List(vm.photos) { model in
                DownloadingImagesRow(model: model)
            }
            .listStyle(InsetListStyle())
            .navigationTitle("Downloading Images")
        }
    }
}

struct DownloadingImagesFromInternet_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImagesFromInternet()
    }
}
