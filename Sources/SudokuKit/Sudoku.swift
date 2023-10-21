//
//  Sudoku.swift
//
//
//  Created by George on 21/10/2023.
//

import Foundation

public class Sudoku {
    private var board: PuzzleBoard
    
    private var counter: Int = 0
    
    private let N = 9
    private var SRN: Int {
        Int(sqrt(Double(N)))
    }
    
    /// Initialises with empty NxN board filled by zeros
    init(N: Int = 9) {
        self.board = [[Int]](
            repeating: [Int](repeating: 0, count: N),
            count: N
        )
    }
    
    private func nextEmptyCell() -> Cell? {
        let numCells = (board.count*board[0].count)
        for idx in 0..<numCells {
            let cell = Cell(
                row: idx/N,
                col: idx%N
            )
            
            if board.value(forCell: cell) == 0 {
                return cell
            }
        }
        
        return nil
    }
    
    private func rowSafe(rowIndex: Int, value: Int) -> Bool {
        !board[rowIndex].contains(value)
    }
    
    private func colSafe(colIndex: Int, value: Int) -> Bool {
        for row in board {
            if row[colIndex] == value {
                return false
            }
        }
        
        return true
    }
    
    private func boxSafe(cell: Cell, value: Int) -> Bool {
        let boxStartRow = cell.row - cell.row % 3
        let boxStartCol = cell.col - cell.col % 3
        
        for rowIndex in 0...2 {
            for colIndex in 0...2 {
                if board[boxStartRow + rowIndex][boxStartCol + colIndex] == value {
                    return false
                }
            }
        }
        
        return true
    }
    
    public func canPlace(value: Int, forCell cell: Cell) -> Bool {
        guard board.value(forCell: cell) == 0 else {
            // Already filled
            return false
        }
        
        return rowSafe(rowIndex: cell.row, value: value)
        && colSafe(colIndex: cell.col, value: value)
        && boxSafe(cell: cell, value: value)
    }
    
    func generateBoard(withDifficulty difficulty: Difficulty = .easy) -> PuzzleBoard {
        for i in 0..<SRN {
            let start = i * SRN
            let end = start+SRN
            
            var numbers = [Int](1...9)
            for row in start..<end {
                for col in start..<end {
                    if let number = numbers.randomElement() {
                        self.board[row][col] = number
                        
                        numbers.removeAll(where: { $0 == number })
                    }
                }
            }
        }
        
        _ = finishGenerating(row: 0, col: SRN)
        
        return pokeHoles(numHoles: difficulty.numHolesRange.randomElement() ?? 40)
    }
    
    private func pokeHoles(numHoles: Int = 50) -> PuzzleBoard {
        var gameBoard: PuzzleBoard = self.board
        
        #if DEBUG
        gameBoard.printBoard()
        #endif
        
        for _ in 0 ..< numHoles {
            var row = Int.random(in: 0 ..< N)
            var col = Int.random(in: 0 ..< N)
            
            while gameBoard[row][col] == 0 {
                row = Int.random(in: 0 ..< N)
                col = Int.random(in: 0 ..< N)
            }
            
            gameBoard[row][col] = 0
        }
        
        return gameBoard
    }
    
    private func finishGenerating(row: Int, col: Int) -> Bool {
        if row == self.N-1 && col == self.N {
            return true
        }
        
        var nextRow = row
        var nextCol = col
        
        if col == self.N {
            nextRow += 1
            nextCol = 0
        }
        
        if self.board[nextRow][nextCol] != 0 {
            return finishGenerating(row: nextRow, col: nextCol+1)
        }
        
        for num in [Int](1...9).shuffled() {
            if canPlace(value: num, forCell: Cell(row: nextRow, col: nextCol)) {
                self.board[nextRow][nextCol] = num
                
                if finishGenerating(row: nextRow, col: nextCol) {
                    return true
                }
                
                self.board[nextRow][nextCol] = 0
            }
        }
        
        return false
    }
}
