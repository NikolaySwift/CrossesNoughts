//
//  ContentView.swift
//  CrossesNoughts
//
//  Created by NikolayD on 28.09.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            BoardView()
                .frame(
                    height: UIScreen.main.bounds.width
                )
        }
    }
}

#Preview {
    ContentView()
}
