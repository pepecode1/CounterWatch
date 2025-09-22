//
//  SettingsView.swift
//  CounterWatch
//
//  Created by Pepe Ruiz on 21/09/25.
//
import SwiftUI
/// Vista para configurar el intervalo de alertas con botones.
struct SettingsView: View {
    /// ViewModel compartido para actualizar el intervalo.
    @ObservedObject var viewModel: CounterViewModel
    /// Valor temporal para el intervalo.
    @State private var tempInterval: Int
    /// Inicializa la vista con el ViewModel.
    /// - Parameter viewModel: ViewModel para gestionar el intervalo.
    init(viewModel: CounterViewModel) {
        self.viewModel = viewModel
        self._tempInterval = State(initialValue: viewModel.model.alertInterval)
    }
    var body: some View {
        VStack {
            Text("Alerta cada: \(tempInterval) personas")
                .font(.headline)
            HStack {
                Button(action: {
                    if tempInterval > 1 {
                        tempInterval -= 1
                    }
                }) {
                    Text("−")
                        .font(.title2)
                        .frame(width: 40, height: 40)
                        .background(Color.gray)
                        .clipShape(Circle())
                }
                Button(action: {
                    tempInterval += 1
                }) {
                    Text("+")
                        .font(.title2)
                        .frame(width: 40, height: 40)
                        .background(Color.gray)
                        .clipShape(Circle())
                }
            }
            Button("Guardar") {
                viewModel.updateAlertInterval(tempInterval)
            }
            .padding()
        }
    }
}
