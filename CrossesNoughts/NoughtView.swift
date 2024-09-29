//
//  NoughtView.swift
//  CrossesNoughts
//
//  Created by NikolayD on 28.09.2024.
//

import SwiftUI

struct NoughtView: View {
    @State private var end = CGFloat.zero
 
    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            
            Path { path in
                path.addArc(
                    center: CGPoint(x: size / 2, y: size / 2),
                    radius: size * 0.4,
                    startAngle: .degrees(-90),
                    endAngle: .degrees(270),
                    clockwise: false
                )
            }
            .trim(from: 0, to: end)
            .stroke(Color.black, lineWidth: size * 0.1)
            .animation(.easeInOut, value: end)
        }
        .onAppear {
            end = 1
        }
    }
}

#Preview {
    NoughtView()
        .frame(width: 200, height: 200)
}
