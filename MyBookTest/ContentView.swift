//
//  ContentView.swift
//  MyBookTest
//
//  Created by Александр Печинкин on 14.08.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var bookVM = BookVM()
    
    @State private var showAudio = true
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.bgMain.ignoresSafeArea()
            
            AudioView()
                .environmentObject(bookVM)
                .offset(x: showAudio ? 0 : -UIScreen.main.bounds.width)
            
            AudioListView(showAudio: $showAudio)
                .environmentObject(bookVM)
                .offset(x: showAudio ? UIScreen.main.bounds.width : 0)
            
            ChangeViewButton(showAudio: $showAudio)
        }
    }
}

#Preview {
    ContentView()
}

