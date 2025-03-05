//
//  ComputerList.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//

import SwiftUI

struct DevicesList: View {
    let devices: [DeviceData]
    let onSelect: (DeviceData) -> Void // Callback for item selection

    var body: some View {
        List(devices) { device in
            Button {
                onSelect(device)
            } label: {
                VStack(alignment: .leading) {
                    AssignmentText(text: device.name)
                    if let color = device.data?.color {
                        AssignmentText(text: "Color: \(color)")
                    }
                    if let description = device.data?.description {
                        AssignmentText(text: "Description: \(description)")
                    }
                    if let price = device.data?.price {
                        AssignmentText(text: "Price: \(price)")
                    }
                }
            }
        }
    }
}
