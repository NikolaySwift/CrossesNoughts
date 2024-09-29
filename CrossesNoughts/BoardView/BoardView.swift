//
//  BoardView.swift
//  CrossesNoughts
//
//  Created by NikolayD on 29.09.2024.
//

import SwiftUI



struct BoardView: View {
    @State private var boardViewVM = BoardViewViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            let lineWidth = size * 0.05
            let rowSize = (size - size * 0.1 * 3) / 3
            
            Path { path in
                path.move(to: CGPoint(x: size * 0.1, y: size * (0.35)))
                path.addLine(to: CGPoint(x: size * 0.9, y: size * 0.35))
            }
            .trim(from: 0, to: boardViewVM.end)
            .stroke(Color.black, lineWidth: lineWidth)
            .animation(.easeInOut, value: boardViewVM.end)
            
            Path { path in
                path.move(to: CGPoint(x: size * 0.1, y: size * 0.65))
                path.addLine(to: CGPoint(x: size * 0.9, y: size * 0.65))
            }
            .trim(from: 0, to: boardViewVM.end)
            .stroke(Color.black, lineWidth: lineWidth)
            .animation(.easeInOut.delay(0.3), value: boardViewVM.end)
            
            Path { path in
                path.move(to: CGPoint(x: size * 0.35, y: size * 0.1))
                path.addLine(to: CGPoint(x: size * 0.35, y: size * 0.9))
            }
            .trim(from: 0, to: boardViewVM.end)
            .stroke(Color.black, lineWidth: lineWidth)
            .animation(.easeInOut.delay(0.6), value: boardViewVM.end)
            
            Path { path in
                path.move(to: CGPoint(x: size * 0.65, y: size * 0.1))
                path.addLine(to: CGPoint(x: size * 0.65, y: size * 0.9))
            }
            .trim(from: 0, to: boardViewVM.end)
            .stroke(Color.black, lineWidth: lineWidth)
            .animation(.easeInOut.delay(0.9), value: boardViewVM.end)
            
            
            ForEach(0..<3) { xIteration in
                ForEach(0..<3) { yIteration in
                    CellView(status: boardViewVM.cellsStatus[xIteration][yIteration])
                        .frame(width: size * 0.2, height: size * 0.2)
                        .contentShape(Rectangle())
                        .offset(
                            x: rowSize / 2 + Double(xIteration) * (rowSize + lineWidth),
                            y: rowSize / 2 + Double(yIteration) * (rowSize + lineWidth)
                        )
                        .onTapGesture {
                            boardViewVM.userStep(x: xIteration, y: yIteration)
                        }
                        .alert(
                            "Game is over",
                            isPresented: $boardViewVM.showAlert,
                            actions: { Button("OK", action: boardViewVM.clearBoard)}
                        ) {
                            Text(boardViewVM.alertMessage)
                        }
                }
            }
        }
        .onAppear {
            boardViewVM.end = 1
        }
        .rotationEffect(.degrees(boardViewVM.isBoardHidden ? 720 : 0))
        .scaleEffect(boardViewVM.isBoardHidden ? 0 : 1)
    }
}

#Preview {
    BoardView()
        .frame(width: 300, height: 300)
}
