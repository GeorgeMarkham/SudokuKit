//
//  Cell.swift
//
//
//  Created by George on 21/10/2023.
//

import Foundation

/// Represents a Cell
public class Cell {
    internal var row: Int
    internal var col: Int
    
    internal init(row: Int, col: Int) {
        self.row = row
        self.col = col
    }
    
    internal func incrementRow() {
        row += 1
    }
    
    internal func incrementCol() {
        col += 1
    }
    
    internal func resetCol() {
        col = 0
    }
}
