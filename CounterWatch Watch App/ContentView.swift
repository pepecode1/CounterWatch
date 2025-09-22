//
//  ContentView.swift
//  CounterWatch Watch App
//
//  Created by Pepe Ruiz on 21/09/25.
//
import SwiftUI
/// Vista principal que muestra el contador y los controles.
struct ContentView: View {
    /// ViewModel que gestiona la lógica del contador.
    @StateObject private var viewModel = CounterViewModel()
    var body: some View {
        NavigationView {
            VStack {
                Text("\(viewModel.model.count)")
                    .font(.system(size: 40, weight: .bold))
                    .padding()
                    /// Gesto de doble toque en la pantalla
                    .gesture(TapGesture(count: 2).onEnded {
                        viewModel.incrementCount()
                    })
                HStack {
                    Button(action: {
                        viewModel.decrementCount()
                    }) {
                        Text("−")
                            .font(.title)
                            .frame(width: 60, height: 60)
                            .background(Color.red)
                            .clipShape(Circle())
                    }
                    if #available(watchOS 11.0, *) {
                        Button(action: {
                            viewModel.incrementCount()
                        }) {
                            Text("+")
                                .font(.title)
                                .frame(width: 60, height: 60)
                                .background(Color.green)
                                .clipShape(Circle())
                        }
                        /// Asocia el botón "+" al gesto de doble toque físico.
                        .handGestureShortcut(.primaryAction)
                    } else {
                        Button(action: {
                            viewModel.incrementCount()
                        }) {
                            Text("+")
                                .font(.title)
                                .frame(width: 60, height: 60)
                                .background(Color.green)
                                .clipShape(Circle())
                        }
                        .gesture(TapGesture(count: 2).onEnded {
                            viewModel.incrementCount()
                        })
                    }
                }
                NavigationLink(
                    destination: SettingsView(viewModel: viewModel),
                    label: {
                        Text("Configurar")
                            .font(.footnote)
                    })
            }
            .navigationTitle("Contador")
        }
    }
}
/// Vista previa para ContentView.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
