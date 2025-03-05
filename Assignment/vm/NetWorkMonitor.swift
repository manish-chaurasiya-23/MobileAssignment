//
//  NetWorkMonitor.swift
//  Assignment
//
//  Created by Manish Kumar on 05/03/25.
//

import Network
import Foundation

class NetworkManager: ObservableObject {
    let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    @Published var isConnected = true
    
    init() {
        monitor.pathUpdateHandler = { [weak self] isConnected2Internet in
            DispatchQueue.main.async {
                self?.isConnected = isConnected2Internet.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
    
}
