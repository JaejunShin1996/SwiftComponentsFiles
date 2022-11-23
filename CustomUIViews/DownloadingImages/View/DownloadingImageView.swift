//
//  DownloadingImageView.swift
//  CustomUIViews
//
//  Created by Jaejun Shin on 22/11/2022.
//

import SwiftUI

struct DownloadingImageView: View {
    @StateObject var vm: ImageViewModel

    init(url: String, key: String) {
        _vm = StateObject(wrappedValue: ImageViewModel(url: url, key: key))
    }

    var body: some View {
        ZStack {
            if vm.isLoading {
                ProgressView()
            } else if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(Circle())
            }
        }
    }
}

struct DownloadingImageView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImageView(url: "https://via.placeholder.com/600/92c952", key: "1")
            .frame(width: 75, height: 75)
            .previewLayout(.sizeThatFits)
    }
}
