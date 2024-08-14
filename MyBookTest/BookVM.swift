//
//  BookVM.swift
//  MyBookTest
//
//  Created by Александр Печинкин on 14.08.2024.
//

import Foundation
import AVFoundation

class BookVM: ObservableObject {
    @Published var book: Book
    @Published var audioListen: Audio? {
        didSet {
            setSong(audioListen?.path ?? "")
        }
    }
    private var player: AVAudioPlayer?
    private var timer: Timer?
    @Published public var maxDuration: Double = 10.0
    @Published public var progress: Double = 0.0
    @Published var isPlay = false
    
    init() {
        book = mockBook
        audioListen = book.audio.first
    }
    
    public func setSpeed(_ speed: Float) {
        player?.rate = speed
    }
    
    // MARK: - Функция для показа верного формата
    public func progressFormat(_ duration: Double) -> String {
        let minutes = Int(duration / 60)
        let seconds = Int(duration.truncatingRemainder(dividingBy: 60))
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    public func playPause() {
        if !isPlay {
            player?.play()
            startTimer()
        } else {
            player?.pause()
            pauseTimer()
        }
        isPlay.toggle()
    }
    
    
    // MARK: - Работа с временем
    public func setTime(value: Double) {
        guard let time = TimeInterval(exactly: value) else { return }
        player?.currentTime = time
    }
    
    public func skipSeconds(_ seconds: Double) {
        progress += seconds
        setTime(value: progress)
    }
    
    // MARK: - Установление аудио
    public func setSong(_ name: String) {
        guard let audioPath = Bundle.main.path(forResource: name, ofType: "mp3") else { return }
        stopTimer()
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
            player?.enableRate = true 
            player?.rate = 1.0
            maxDuration = player?.duration ?? 0.0
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Переключение треков
    public func setBackAudio() {
        guard let indexNowAudio = book.audio.firstIndex(where: {$0.id == audioListen?.id}) else { return }
        stopTimer()
        if indexNowAudio == 0 {
            audioListen = book.audio[book.audio.count - 1]
        } else {
            audioListen = book.audio[indexNowAudio - 1]
        }
        playPause()
    }
    public func setNextAudio() {
        guard let indexNowAudio = book.audio.firstIndex(where: {$0.id == audioListen?.id}) else { return }
        stopTimer()
        if indexNowAudio == book.audio.count - 1 {
            audioListen = book.audio[0]
        } else {
            audioListen = book.audio[indexNowAudio + 1]
        }
        playPause()
    }
    
    
    
    // MARK: - Работа с таймером
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [self] _ in
            if maxDuration - progress > 0 {
                progress += 0.1
            }
            else {
                stopTimer()
            }
        }
    }
    
    private func pauseTimer() {
        timer?.invalidate()
    }
    
    private func stopTimer() {
        isPlay = false
        timer?.invalidate()
        progress = 0
    }
}
