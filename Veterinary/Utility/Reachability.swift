//
//  Reachability.swift
//  Veterinary
//
//  Created by Apple on 25/06/22.
//

import Network
import Foundation

class Reachability {

    static var shared = Reachability()
    lazy private var monitor = NWPathMonitor()

    var isConnected: Bool {
        return monitor.currentPath.status == .satisfied
    }

    func startNetworkReachabilityObserver() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                NotificationCenter.default.post(name: .InternetAvailable, object: nil)
            } else if path.status == .unsatisfied {
                NotificationCenter.default.post(name: .InternetUnAvailable, object: nil)
            }
        }
        let queue = DispatchQueue.global(qos: .background)
        monitor.start(queue: queue)
    }
}

public extension Notification.Name {
    static let InternetAvailable = Notification.Name("InternetAvailable")
    static let InternetUnAvailable = Notification.Name("InternetUnAvailable")
}
