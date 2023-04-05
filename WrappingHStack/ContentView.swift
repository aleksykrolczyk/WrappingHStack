//
//  ContentView.swift
//  WrappingHStack
//
//  Created by Aleksy Krolczyk on 05/04/2023.
//

import SwiftUI

struct ContentView: View {
    let contents = (0 ..< 12).map { String($0) }
    
    var body: some View {
        WrappingHStack(viewsPerRow: 3) {
            ForEach(contents, id: \.self) { item in
                Text(item)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
