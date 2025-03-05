//
//  ContentView.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var path: [DeviceData] = [] // Navigation path

    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if !viewModel.data.isEmpty {
                    DevicesList(devices: viewModel.data) { selectedComputer in
                        viewModel.navigateToDetail(navigateDetail: selectedComputer)
                    }
                } else {
                    ProgressView("Loading...")
                }
                if viewModel.isOffline{
                    Text("Cached Data Displayed")
                }
            }
            .onChange(of: viewModel.navigateDetail, {
                let navigate = viewModel.navigateDetail
                path.append(navigate!)
            })
            .navigationTitle("Devices")
            .navigationDestination(for: DeviceData.self) { computer in
                DetailView(device: computer)
            }
            .onAppear {
                let navigate = viewModel.navigateDetail
                if (navigate != nil) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        path.append(navigate!)
                    }
                }
            }
        }
    }
}
