//
//  InetConnectionManager.swift
//  FinalProject_Start_WithTests
//
//  Created by Igor Kalennyy on 12/12/17.
//  Copyright © 2017 A290/A590 Fall 2017 - ikalenny. All rights reserved.
//

import Foundation

class INetConnectionManager{
    
    
    class func updateUserInterface() {
        guard let status = Network.reachability?.status else { return }
        switch status {
        case .unreachable:
            //send the alert on a main thread
            print("unreachable")
        case .wifi:
            //send the alert on a main thread
            print("Internew only via wifi")
        case .wwan:
            print("only via wan")
        }
        print("Reachability Summary")
        print("Status:", status)
        print("HostName:", Network.reachability?.hostname ?? "nil")
        print("Reachable:", Network.reachability?.isReachable ?? "nil")
        print("Wifi:", Network.reachability?.isReachableViaWiFi ?? "nil")
    }
    @objc
    class func statusManager(_ notification: Notification) {
        updateUserInterface()
    }

}
