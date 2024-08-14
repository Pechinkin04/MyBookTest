//
//  Book.swift
//  MyBookTest
//
//  Created by Александр Печинкин on 14.08.2024.
//

import Foundation

var mockBook = Book(img: "oblomov",
                    audio: [
                        Audio(num: 1,
                              desc: "part one",
                              path: "Oblomov - 1-01 - Bibe.ru"),
                        Audio(num: 2,
                              desc: "part two",
                              path: "Oblomov - 1-02 - Bibe.ru"),
                        Audio(num: 3,
                              desc: "part three",
                              path: "Oblomov - 1-03 - Bibe.ru"),
                        Audio(num: 4,
                              desc: "part four",
                              path: "Oblomov - 1-04 - Bibe.ru"),
                    ])

struct Book: Identifiable {
    var id = UUID()
    
    var img: String
    var audio: [Audio]
}

struct Audio: Identifiable {
    var id = UUID()
    
    var num: Int
    var desc: String
    var path: String
}
