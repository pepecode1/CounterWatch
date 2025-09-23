//
//  ContentView.swift
//  CounteriPhone
//
//  Created by Pepe Ruiz on 23/09/25.
//

import WatchConnectivity
import SwiftUI
import Combine
/// ViewModel para la app de iPhone, sincroniza con Watch.
class CounteriPhoneViewModel: NSObject, ObservableObject, WCSessionDelegate {
    /// Conteo actual recibido del Watch.
    @Published var count: Int = 0
    /// Historial de conteos.
    @Published var history: [Int] = []
    /// Sesión para sincronización con Watch.
    private var session: WCSession?
    /// Suite de UserDefaults compartida con App Group.
    private let userDefaults = UserDefaults(suiteName: "group.com.tuempresa.counterwatch")
    override init() {
        super.init()
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
        if let savedCount = userDefaults?.integer(forKey: "currentCount") {
            count = savedCount
            history.append(savedCount)
        }
    }
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
    /// Recibe mensajes del Watch.
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        DispatchQueue.main.async {
            if let receivedCount = message["count"] as? Int {
                self.count = receivedCount
                self.history.append(receivedCount)
                self.userDefaults?.set(receivedCount, forKey: "currentCount")
            }
        }
    }
    /// Envía un mensaje al Watch para resetear el conteo.
    func sendResetToWatch() {
        session?.sendMessage(["action": "reset"], replyHandler: nil)
        count = 0
        history.append(0)
        userDefaults?.set(0, forKey: "currentCount")
    }
    func sessionDidBecomeInactive(_ session: WCSession) {}
    func sessionDidDeactivate(_ session: WCSession) {}
}
/// Vista principal de la app iPhone.
struct CounteriPhoneContentView: View {
    /// ViewModel para gestionar el conteo y el historial.
    @StateObject private var viewModel = CounteriPhoneViewModel()
    var body: some View {
        NavigationView {
            VStack {
                Text("Conteo actual: \(viewModel.count)")
                    .font(.title)
                    .accessibilityIdentifier("iPhoneCounterText")
                List(viewModel.history, id: \.self) { count in
                    Text("Conteo: \(count)")
                        .accessibilityIdentifier("historyItem")
                }
                Button("Resetear en Watch") {
                    viewModel.sendResetToWatch()
                }
                .accessibilityIdentifier("resetButton")
            }
            .navigationTitle("Contador iPhone")
        }
    }
}
/// Vista previa para CounteriPhoneContentView.
struct CounteriPhoneContentView_Previews: PreviewProvider {
    static var previews: some View {
        CounteriPhoneContentView()
    }
}
