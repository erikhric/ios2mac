//
//  MacOSBridge.swift
//  macOSBrigde
//
//  Created by Hric, Erik on 16.04.21.
//

import Foundation
import AppKit

class MacOSBridge: NSObject, iOS2Mac {
    
    var iosListener: mac2iOS?
    
    required override init() {
        super.init()
    }
    
    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    
    func createBarItem() {
        print("CreateBarItem")
        if let button = statusItem.button {
            button.title = "🏠"
            button.target = self
            button.action = #selector(MacOSBridge.statusItemClicked)
        }
    }
    
    @objc func statusItemClicked() {
        print("Clicked Item")
        iosListener?.barItemClicked()
    }
}
