//
//  RemoteImage.swift
//  FeeUp
//
//  Created by Amir Ardalan on 8/17/23.
//

import Foundation
import SwiftUI
import Kingfisher

struct RemoteImage: View {
    let url: URL
    var body: some View {
        KFImage(url)
            .setProcessor(DownsamplingImageProcessor(size: CGSize(width: 500, height: 500)))
            .fade(duration: 0.3)
    }
}
