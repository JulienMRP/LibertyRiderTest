//
//  NetworkManager.swift
//  LibertyRiders Test
//
//  Created by Perso on 9/8/23.
//

import Foundation
import Network

class NetworkManager {
    private let networkMonitor = NWPathMonitor()
    private var status: NWPath.Status = .satisfied

    init() {
        setupNetworkChange()
        startMonitoring()
    }
    
    private func setupNetworkChange() {
        networkMonitor.pathUpdateHandler = { [weak self] path in
            self?.status = path.status
        }
    }
    
    private func startMonitoring() {
        let queue = DispatchQueue(label: "NetworkManager")
        networkMonitor.start(queue: queue)
    }
    
    func isConnected() -> Bool {
        return status == .satisfied
    }
}
