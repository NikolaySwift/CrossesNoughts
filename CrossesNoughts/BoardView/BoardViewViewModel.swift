//
//  BoardViewViewModel.swift
//  CrossesNoughts
//
//  Created by NikolayD on 29.09.2024.
//

import SwiftUI
import Observation

enum CellStatus{
    case empty
    case cross
    case nought
}

@Observable
final class BoardViewViewModel {
    var end = CGFloat.zero
    
   var cellsStatus: [[CellStatus]] = [
        [.empty, .empty, .empty],
        [.empty, .empty, .empty],
        [.empty, .empty, .empty]
    ]
    
    var player: CellStatus = .cross
    var playerTurn = true
    
    var showAlert = false
    var alertMessage = ""
    
    var isBoardHidden = false
    
    func opponentStep() {
        var toChoose: [(Int, Int)] = []
        for iterX in 0..<cellsStatus.count {
            for iterY in 0..<cellsStatus[iterX].count {
                if cellsStatus[iterX][iterY] == .empty {
                    toChoose.append((iterX, iterY))
                }
            }
        }
        
        if let chosenCell = toChoose.randomElement() {
            cellsStatus[chosenCell.0][chosenCell.1] = .nought
            
            if isWinLine(withCellX: chosenCell.0, andY: chosenCell.1) {
                alertMessage = "Opponent win"
                showAlert.toggle()
                return
            }
            
            if isBoardFilled() {
                alertMessage = "board is filled"
                showAlert.toggle()
                return
            }
            
            playerTurn.toggle()
        }
    }
    
    func userStep(x: Int, y: Int) {
        if cellsStatus[x][y] == .empty && playerTurn {
            cellsStatus[x][y] = player
            
            if isWinLine(withCellX: x, andY: y) {
                alertMessage = "Player win"
                showAlert.toggle()
                return
            }
            
            if isBoardFilled() {
                alertMessage = "board is filled"
                showAlert.toggle()
                return
            }
            
            playerTurn.toggle()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in 
                opponentStep()
            }
        }
    }
    
    private func isWinLine(withCellX x: Int,andY y: Int) -> Bool {
        return cellsStatus[x][0] == cellsStatus[x][1]
            && cellsStatus[x][0] == cellsStatus[x][2]
            || cellsStatus[0][y] == cellsStatus[1][y]
            && cellsStatus[0][y] == cellsStatus[2][y]
            || x == y
            && cellsStatus[1][1] == cellsStatus[0][0]
            && cellsStatus[1][1] == cellsStatus[2][2]
            || x == 1 && y == 1
            && cellsStatus[1][1] == cellsStatus[0][2]
            && cellsStatus[1][1] == cellsStatus[2][0]
            || x == 0 && y == 2
            && cellsStatus[1][1] == cellsStatus[0][2]
            && cellsStatus[1][1] == cellsStatus[2][0]
            || x == 2 && y == 0
            && cellsStatus[1][1] == cellsStatus[0][2]
            && cellsStatus[1][1] == cellsStatus[2][0]
    }
    
    private func isBoardFilled() -> Bool {
        let boardToCheck = cellsStatus.flatMap { $0 }
        return !boardToCheck.contains(.empty)
    }
    
    func clearBoard() {
        withAnimation(.easeIn(duration: 0.5)) {
            isBoardHidden.toggle()
            
            cellsStatus = [
                [.empty, .empty, .empty],
                [.empty, .empty, .empty],
                [.empty, .empty, .empty]
            ]
            
            playerTurn = true
        }
        
        withAnimation(.easeOut(duration: 1).delay(0.5)) {
            isBoardHidden.toggle()
        }
        
    }
}
