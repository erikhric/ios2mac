//
//  iOS2macApp.swift
//  iOS2mac
//
//  Created by Hric, Erik on 15.04.21.
//

import SwiftUI

@main
struct iOS2macApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        appDelegate.setUpHomeManager()
        return WindowGroup {
            ContentView().environmentObject(appDelegate)
        }
    }
}
