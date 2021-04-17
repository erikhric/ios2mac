//
//  ContentView.swift
//  iOS2mac
//
//  Created by Hric, Erik on 15.04.21.
//

import SwiftUI
import HomeKit

struct ContentView: View {
    
    @EnvironmentObject var appDelegate: AppDelegate
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
            Button("Create item") {
                appDelegate.setUpHomeManager()
                appDelegate.ios2mac?.createBarItem()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
