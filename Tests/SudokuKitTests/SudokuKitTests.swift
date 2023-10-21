import XCTest
@testable import SudokuKit

final class SudokuKitTests: XCTestCase {
    func testCreateAnEasyBoard() throws {
        let difficulty: Difficulty = .easy
        
        let sudoku = Sudoku(N: 9)
        let board = sudoku.generateBoard(withDifficulty: difficulty)
        
        let zeroCount = board.reduce(0) { zeroCount, row in
            zeroCount + row.filter {  $0 == 0 }.count
        }
        
        XCTAssertTrue(
            Difficulty.easy.numHolesRange.contains(zeroCount),
            "\(zeroCount) is not in the range \(difficulty.numHolesRange)"
        )
    }
    
    func testCreateAMediumBoard() throws {
        let difficulty: Difficulty = .medium
        
        let sudoku = Sudoku(N: 9)
        let board = sudoku.generateBoard(withDifficulty: difficulty)
        
        let zeroCount = board.reduce(0) { zeroCount, row in
            zeroCount + row.filter {  $0 == 0 }.count
        }
        
        XCTAssertTrue(
            difficulty.numHolesRange.contains(zeroCount),
            "\(zeroCount) is not in the range \(difficulty.numHolesRange)"
        )
    }
    
    func testCreateAHArdBoard() throws {
        let difficulty: Difficulty = .hard
        
        let sudoku = Sudoku(N: 9)
        let board = sudoku.generateBoard(withDifficulty: difficulty)
        
        let zeroCount = board.reduce(0) { zeroCount, row in
            zeroCount + row.filter {  $0 == 0 }.count
        }
        
        XCTAssertTrue(
            difficulty.numHolesRange.contains(zeroCount),
            "\(zeroCount) is not in the range \(difficulty.numHolesRange)"
        )
    }
}
