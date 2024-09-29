//
//  CellView.swift
//  CrossesNoughts
//
//  Created by NikolayD on 29.09.2024.
//

import SwiftUI

struct CellView: View {
    let status: CellStatus
    
    var body: some View {
        VStack {
            if status == .cross {
                CrossView()
            } else if status == .nought {
                NoughtView()
            }
        }
    }
}

#Preview {
    CellView(status: .empty)
        .frame(width: 200, height: 200)
}
