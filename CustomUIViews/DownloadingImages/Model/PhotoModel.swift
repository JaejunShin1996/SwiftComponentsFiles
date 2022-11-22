//
//  PhotoModel.swift
//  CustomUIViews
//
//  Created by Jaejun Shin on 22/11/2022.
//

import Foundation

/*
albumId    1
id    1
title    "accusamus beatae ad facilis cum similique qui sunt"
url    "https://via.placeholder.com/600/92c952"
thumbnailUrl    "https://via.placeholder.com/150/92c952"
*/

struct PhotoModel: Identifiable, Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}