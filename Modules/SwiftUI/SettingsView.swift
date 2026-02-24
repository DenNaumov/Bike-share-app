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
            .applyDarkListBackground()
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
        .preferredColorScheme(.dark)
    }
}

private extension View {
    @ViewBuilder
    func applyDarkListBackground() -> some View {
        if #available(iOS 16.0, *) {
            self
                .scrollContentBackground(.hidden)
                .background(Color.black)
        } else {
            self
                .background(Color.black)
        }
    }
}

#Preview {
    SettingsView(onDismiss: {})
}
