//
//  CounterViewModel.swift
//  CounterWatch
//
//  Created by Pepe Ruiz on 21/09/25.
//
import WatchKit
import WatchConnectivity
import Combine
import WidgetKit
/// ViewModel que gestiona la lógica del contador y las interacciones del Apple Watch.
class CounterViewModel: NSObject, ObservableObject, WCSessionDelegate {
    /// Estado del contador, observable para actualizar la UI.
    @Published var model: CounterModel
    /// Suite de UserDefaults compartida con App Group.
    private let userDefaults = UserDefaults(suiteName: "group.com.pepecode.counterwatch")
    /// Sesión para sincronización con iPhone.
    private var session: WCSession?
    /// Inicializa el ViewModel con un modelo.
    /// - Parameter model: Modelo inicial del contador.
    init(model: CounterModel = CounterModel()) {
        self.model = model
        super.init()
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
    }
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
    /// Incrementa el contador y activa vibraciones.
    func incrementCount() {
        model.count += 1
        userDefaults?.set(model.count, forKey: "currentCount")
        sendCountToPhone()
        WidgetCenter.shared.reloadAllTimelines()
        playHaptic()
        if model.count % model.alertInterval == 0 {
            playSpecialHaptic()
        }
    }
    /// Decrementa el contador si es mayor a 0 y activa vibración.
    func decrementCount() {
        if model.count > 0 {
            model.count -= 1
            userDefaults?.set(model.count, forKey: "currentCount")
            sendCountToPhone()
            WidgetCenter.shared.reloadAllTimelines()
            playHaptic()
        }
    }
    /// Actualiza el intervalo de alertas y lo guarda en UserDefaults.
    /// - Parameter interval: Nuevo intervalo para alertas.
    func updateAlertInterval(_ interval: Int) {
        if interval > 0 {
            model.alertInterval = interval
            userDefaults?.set(interval, forKey: "alertInterval")
            sendCountToPhone()
        }
    }
    /// Envía el conteo al iPhone.
    func sendCountToPhone() {
        session?.sendMessage(["count": model.count], replyHandler: nil)
    }
    /// Recibe mensajes del iPhone (e.g., reset).
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        if let action = message["action"] as? String, action == "reset" {
            model.count = 0
            userDefaults?.set(0, forKey: "currentCount")
            WidgetCenter.shared.reloadAllTimelines()
            sendCountToPhone()
        }
    }
    /// Reproduce una vibración estándar para cada conteo usando WatchKit.
    func playHaptic() {
        WKInterfaceDevice.current().play(.click)
    }
    /// Reproduce una vibración especial para múltiplos del intervalo usando WatchKit.
    func playSpecialHaptic() {
        WKInterfaceDevice.current().play(.notification)
    }
}
