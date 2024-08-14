//
//  MyBookTestUnit.swift
//  MyBookTestUnit
//
//  Created by Александр Печинкин on 14.08.2024.
//

import XCTest

@testable import MyBookTest

// MARK: - Для примера было написано три теста
class BookVMTests: XCTestCase {

    var viewModel: BookVM!
    var mockBook: Book!

    override func setUp() {
        super.setUp()
        mockBook = Book(img: "", audio: [
            Audio(num: 1, desc: "description1", path: "1"),
            Audio(num: 2, desc: "description2", path: "2"),
        ])
        viewModel = BookVM()
        viewModel.book = mockBook
        viewModel.audioListen = mockBook.audio.first
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }

    // MARK: - testSetSong: Проверяет установку песни и максимальной продолжительности.
    func testSetSong() {
        let expectedPath = "Oblomov - 1-01 - Bibe.ru"
        let expectedMaxDuration = 1852.65625

        viewModel.setSong(expectedPath)

        XCTAssertEqual(viewModel.maxDuration, expectedMaxDuration)
    }

    // MARK: - testPlayPause: Проверяет переключение между воспроизведением и паузой.
    func testPlayPause() {
        viewModel.isPlay = false

        viewModel.playPause()

        XCTAssertTrue(viewModel.isPlay)
    }

    // MARK: - testSkipSeconds: Проверяет пропуск секунд.
    func testSkipSeconds() {
        let expectedProgress: Double = 5.0

        viewModel.skipSeconds(expectedProgress)

        XCTAssertEqual(viewModel.progress, expectedProgress)
    }

}
