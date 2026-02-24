//
//  SettingsView.swift
//  Bike App
//
//  Created by Денис Наумов on 23.08.2020.
//  Copyright © 2020 Денис Наумов. All rights reserved.
//

import SwiftUI

struct SettingsView: View {

    var onDismiss: () -> Void

    var body: some View {
        NavigationView {
            List {
                Section {
                    Text("Здесь будут настройки приложения.")
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Настройки")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Закрыть") {
                        onDismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView(onDismiss: {})
}
