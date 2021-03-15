//
//  ContentView.swift
//  I Will Be RIch Soon
//
//  Created by JAY LEE on 2021/03/15.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice(PreviewDevice(rawValue: "iphone 7"))
    }
}
