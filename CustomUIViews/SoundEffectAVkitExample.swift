//
//  SoundEffectAVkitExample.swift
//  CustomUIViews
//
//  Created by Jaejun Shin on 11/11/2022.
//

import AVKit
import SwiftUI

class SoundManager {
    static let instance = SoundManager()

    var player: AVAudioPlayer?

    enum AudioBundle: String {
        case ding
        case tada
    }

    func play(audioTitle: AudioBundle) {
        guard let url = Bundle.main.url(forResource: audioTitle.rawValue, withExtension: ".mp3") else { return }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("error , \(error.localizedDescription)")
        }
    }
}

struct SoundEffectAVkitExample: View {
    var body: some View {
        VStack(spacing: 40) {
            Button {
                SoundManager.instance.play(audioTitle: .ding)
            } label: {
                Text("ding")
                    .font(.largeTitle)
            }

            Button {
                SoundManager.instance.play(audioTitle: .tada)
            } label: {
                Text("tada")
                    .font(.largeTitle)
            }
        }
    }
}

struct SoundEffectAVkitExample_Previews: PreviewProvider {
    static var previews: some View {
        SoundEffectAVkitExample()
    }
}
