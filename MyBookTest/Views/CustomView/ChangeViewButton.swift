//
//  ChangeViewButton.swift
//  MyBookTest
//
//  Created by Александр Печинкин on 14.08.2024.
//

import SwiftUI

struct ChangeViewButton: View {
    @Binding var showAudio: Bool
    var body: some View {
        HStack {
            Image(systemName: showAudio ? "headphones.circle.fill" : "headphones.circle")
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(showAudio ? .blue : .textBlack)
            Image(systemName: showAudio ? "list.bullet.rectangle" : "list.bullet.rectangle.fill")
                .font(.system(size: 27, weight: .bold))
                .foregroundStyle(showAudio ? .textBlack : .blue)
        }
        .frame(width: 100, height: 50)
        .background(Color.white)
        .cornerRadius(60)
        .overlay(
            RoundedRectangle(cornerRadius: 60)
                .stroke(Color.textGray, lineWidth: 2)
        )
        .onTapGesture {
            withAnimation {
                showAudio.toggle()
            }
        }
    }
}

#Preview {
    ChangeViewButton(showAudio: .constant(false))
}
