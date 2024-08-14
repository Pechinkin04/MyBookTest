//
//  AudioListView.swift
//  MyBookTest
//
//  Created by Александр Печинкин on 14.08.2024.
//

import SwiftUI


struct AudioListView: View {
    @EnvironmentObject var bookVM: BookVM
    @Binding var showAudio: Bool
    
    var body: some View {
        VStack {
            List {
                ForEach(bookVM.book.audio) { audio in
                    HStack {
                        Image(bookVM.book.img)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60)
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Key point \(audio.num) of \(bookVM.book.audio.count)")
                                .font(.headline)
                                .fontWeight(.bold)
                                .textCase(.uppercase)
                                .foregroundStyle(.textGray)
                            
                            Text(audio.desc)
                                .font(.headline)
                                .fontWeight(.medium)
                                .foregroundStyle(.textBlack)
                        }
                        Spacer()
                    }
                    .background(Color.bgMain)
                    .onTapGesture {
                        withAnimation {
                            bookVM.audioListen = audio
                            showAudio.toggle()
                            bookVM.playPause()
                        }
                    }
                }
                .listRowBackground(Color.bgMain)
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    AudioListView(showAudio: .constant(true))
        .environmentObject(BookVM())
}
