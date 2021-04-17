//
//  AppDelegate.swift
//  iOS2mac
//
//  Created by Hric, Erik on 16.04.21.
//

import UIKit
import HomeKit

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    
    var ios2mac: iOS2Mac?
    var mgr: HMHomeManager?
    var allPowerControllableAccessories: [HMAccessory] = []
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        loadPlugin()
        return true
    }
    
    
    func loadPlugin() {
        let bundleFile = "macOSBridge.bundle"
        guard let bundleURL = Bundle.main.builtInPlugInsURL?.appendingPathComponent(bundleFile),
              let bundle = Bundle(url: bundleURL),
              let pluginClass = bundle.principalClass as? iOS2Mac.Type else { return }

        ios2mac = pluginClass.init()
        ios2mac?.iosListener = self
    }
}

extension AppDelegate: mac2iOS {
    func barItemClicked() {
        print("Listener received click from macOS")
        allPowerControllableAccessories.first?.turnOn()
    }
}

extension HMAccessory {
    func turnOn() {
        _ = self.services.map {
            $0.characteristics.map {
                if ($0.characteristicType == HMCharacteristicTypePowerState) {
                    $0.writeValue(1) { (e) in
                        print("error while turning on the device \(e?.localizedDescription ?? "")")
                    }
                }
            }
        }
    }
}

extension AppDelegate: HMHomeManagerDelegate {
    
    func setUpHomeManager() {
        mgr = HMHomeManager()
        mgr?.delegate = self
    }
    
    func homeManagerDidUpdateHomes(_ manager: HMHomeManager) {
        print(manager.homes)
        
        var supportedAccessories:[HMAccessory] = []
        
        for home in manager.homes {
            let powerControls = home.accessories
                .filter {
                $0.services.contains {
                    $0.characteristics.contains {
                        $0.characteristicType == HMCharacteristicTypePowerState
                    }
                }
            }
            supportedAccessories.append(contentsOf: powerControls)
        }
        allPowerControllableAccessories = supportedAccessories
    }
}
