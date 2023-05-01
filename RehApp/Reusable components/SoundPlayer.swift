//
//  SoundPlayer.swift
//  RehApp
//
//  Created by Petar Ljubotina on 16.04.2023..
//

import Foundation
import AVFoundation

final class SoundPlayer {

    // MARK: - Properties

    static let shared = SoundPlayer()

    private var soundToPlay: AVAudioPlayer?

    enum SoundType {
        case singleExerciseFinished
        case allExercisesFinished

        var fileName: String {
            switch self {
            case .singleExerciseFinished:
                return "SingleExerciseFinished.mp3"
            case .allExercisesFinished:
                return "AllExercisesFinished.mp3"
            }
        }
    }

    // MARK: - Public methods

    func playSound(_ type: SoundType) {
        guard let path = Bundle.main.path(forResource: type.fileName, ofType: nil) else {
#if DEBUG
            print("Couldn't find the wanted sound.")
#endif
            return
        }
        let url = URL(fileURLWithPath: path)

        do {
            soundToPlay = try AVAudioPlayer(contentsOf: url)
            soundToPlay?.play()
        } catch {
#if DEBUG
            print("Couldn't make the wanted sound.")
#endif
        }
    }
}
