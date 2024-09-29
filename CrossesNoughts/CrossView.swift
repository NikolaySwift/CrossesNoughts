//
//  CrossView.swift
//  CrossesNoughts
//
//  Created by NikolayD on 28.09.2024.
//

import SwiftUI

struct CrossView: View {
    @State private var end = CGFloat.zero
    
    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            
            Path { path in
                path.move(to: CGPoint(x: size * 0.1, y: size * 0.1))
                path.addLine(to: CGPoint(x: size * 0.9, y: size * 0.9))
            }
            .trim(from: 0, to: end)
            .stroke(Color.black, lineWidth: size * 0.1)
            .animation(.easeInOut, value: end)
            
            Path { path in
                path.move(to: CGPoint(x: size * 0.9, y: size * 0.1))
                path.addLine(to: CGPoint(x: size * 0.1, y: size * 0.9))
            }
            .trim(from: 0, to: end)
            .stroke(Color.black, lineWidth: size * 0.1)
            .animation(.easeInOut.delay(0.3), value: end)
        }
        .onAppear {
            end = 1
        }
    }
}

#Preview {
    CrossView()
        .frame(width: 200, height: 200)
}
