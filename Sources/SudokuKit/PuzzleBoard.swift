//
//  PuzzleBoard.swift
//
//
//  Created by George on 21/10/2023.
//

import Foundation

/// Puzzleboard is a grid of NxN integers, normally 9x9
public typealias PuzzleBoard = [[Int]]


extension PuzzleBoard {
    func value(forCell cell: Cell) -> Int {
        self[cell.row][cell.col]
    }
}

// MARK: Debug helper functions
#if DEBUG
extension PuzzleBoard {
    /// Prints the puzzle board to the console
    func printBoard() {
        for row in self {
            print(row)
        }
    }
}
#endif
