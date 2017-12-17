//
//  InetConnectionManager.swift
// Practice Star
// Igor Kalennyy
// "A590 / Spring 2017"
// December 15, 2017
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
