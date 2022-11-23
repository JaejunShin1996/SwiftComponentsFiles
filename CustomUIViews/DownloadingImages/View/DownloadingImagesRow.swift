//
//  DownloadingImagesRow.swift
//  CustomUIViews
//
//  Created by Jaejun Shin on 22/11/2022.
//

import SwiftUI

struct DownloadingImagesRow: View {

    let model: PhotoModel

    var body: some View {
        HStack {
            DownloadingImageView(url: model.url, key: String(model.id))
                .frame(width: 75, height: 75)
            VStack {
                Text(model.title)
                    .font(.headline)

                Text(model.url)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct DownloadingImagesRow_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImagesRow(model: PhotoModel(albumId: 1, id: 1, title: "example", url: "https://via.placeholder.com/600/92c952", thumbnailUrl: "https://via.placeholder.com/150/92c952"))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
