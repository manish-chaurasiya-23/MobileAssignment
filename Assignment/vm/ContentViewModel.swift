//
//  ContentViewModel.swift
//  Assignment
//
//  Created by Kunal on 10/01/25.
//

import Foundation


class ContentViewModel : ObservableObject {
    
    private let apiService = ApiService()
    private let networkManager = NetworkManager()
    @Published var navigateDetail: DeviceData? = nil
    @Published var data: [DeviceData] = []
    @Published var isOffline: Bool = false
    private let cacheKey = "deviceDataCache"
    
    init() {
        checkNetwork { [weak self] flag in
            if flag {
                self?.fetchAPI()
            } else {
                self?.loadCacheData()
            }
        }
    }
    
    private func checkNetwork(completion: @escaping (Bool) -> Void) {
        networkManager.$isConnected
            .receive(on: DispatchQueue.main)
            .assign(to: &$isOffline)
        completion(isOffline)
    }

    func fetchAPI() {
        apiService.fetchDeviceDetails { [weak self] item in
            DispatchQueue.main.async {
                self?.data = item
                self?.cacheData(item)
            }
            
        }
    }
    
    func cacheData(_ items: [DeviceData]) {
        if let data = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(data, forKey: cacheKey)
        }
            
    }
    
    func loadCacheData() {
        if let savedData = UserDefaults.standard.data(forKey: cacheKey) {
            if let cachedItems = try? JSONDecoder().decode([DeviceData].self, from: savedData) {
                DispatchQueue.main.async {
                    self.data = cachedItems
                }
            }
        }
    }
    
    func navigateToDetail(navigateDetail: DeviceData) {
        self.navigateDetail = navigateDetail
    }
    
}
