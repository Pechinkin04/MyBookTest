//
//  AugioView.swift
//  MyBookTest
//
//  Created by Александр Печинкин on 14.08.2024.
//

import SwiftUI

struct AudioView: View {
    @EnvironmentObject var bookVM: BookVM
    @State private var speedX2 = false
    
    var body: some View {
        VStack(spacing: 12) {
            imgAudio
            Spacer().frame(height: 30)
            
            partAndDesc
            
            sliderAndSpeed
            .padding(.vertical, 10)
            
            buttons
            .padding(.bottom, 70)
        }
        .multilineTextAlignment(.center)
        .padding()
    }
    
    var imgAudio: some View {
        Image(bookVM.book.img)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: UIScreen.main.bounds.height * 0.4)
    }
    
    var partAndDesc: some View {
        VStack(spacing: 10) {
            Text("Key point \(bookVM.audioListen?.num ?? 0) of \(bookVM.book.audio.count)")
                .font(.headline)
                .fontWeight(.bold)
                .textCase(.uppercase)
                .foregroundStyle(.textGray)
            
            Text(bookVM.audioListen?.desc ?? "")
                .font(.headline)
                .fontWeight(.medium)
                .foregroundStyle(.textBlack)
        }
    }
    
    var sliderAndSpeed: some View {
        VStack {
            HStack {
                Text("\(bookVM.progressFormat(bookVM.progress))")
                    .fontWeight(.semibold)
                    .foregroundStyle(.textGray)
                    .frame(width: 50)
                Slider(value: Binding(get: {
                    bookVM.progress
                }, set: { newValue in
                    print(newValue)
                    bookVM.progress = newValue
                    bookVM.setTime(value: newValue)
                }),
                       in: 0...bookVM.maxDuration)
                Text("\(bookVM.progressFormat(bookVM.maxDuration))")
                    .fontWeight(.semibold)
                    .foregroundStyle(.textGray)
                    .frame(width: 50)
            }
            
            Button {
                bookVM.setSpeed(speedX2 ? 1 : 2) 
                speedX2.toggle()
            } label: {
                Text("Speed x\(speedX2 ? 2 : 1)")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(.textBlack)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 10)
                    .background(Color.textGray.opacity(0.3))
                    .cornerRadius(6.0)
            }
        }
    }
    
    var buttons: some View {
        HStack(spacing: 14) {
            let sizeBtn: CGFloat = 24
            
            Button {
                withAnimation {
                    bookVM.setBackAudio()
                }
            } label: {
                Image(systemName: "chevron.left.to.line")
                    .font(.system(size: sizeBtn, weight: .semibold))
                    .padding(8)
                    .foregroundStyle(.textBlack)
            }
            
            Button {
                bookVM.skipSeconds(-5)
            } label: {
                Image(systemName: "gobackward.5")
                    .font(.system(size: sizeBtn + 5, weight: .semibold))
                    .padding(8)
                    .foregroundStyle(.textBlack)
            }
            
            Button {
                withAnimation {
                    bookVM.playPause()
                }
            } label: {
                Image(systemName: bookVM.isPlay ? "pause.fill" : "play.fill")
                    .font(.system(size: sizeBtn + 10, weight: .semibold))
                    .padding(8)
                    .foregroundStyle(.textBlack)
            }
            
            Button {
                bookVM.skipSeconds(10)
            } label: {
                Image(systemName: "goforward.10")
                    .font(.system(size: sizeBtn + 5, weight: .semibold))
                    .padding(8)
                    .foregroundStyle(.textBlack)
            }
            
            Button {
                withAnimation {
                    bookVM.setNextAudio()
                }
            } label: {
                Image(systemName: "chevron.right.to.line")
                    .font(.system(size: sizeBtn, weight: .semibold))
                    .padding(8)
                    .foregroundStyle(.textBlack)
            }
        }
        .task {
            if bookVM.isPlay {
                bookVM.progress += 1
            }
        }
    }
}





#Preview {
    AudioView()
        .environmentObject(BookVM())
}
