//
//  CounterModel.swift
//  CounterWatch
//
//  Created by Pepe Ruiz on 21/09/25.
//
import Foundation
/// Modelo que representa el estado del contador y su configuración.
struct CounterModel {
    /// Número actual de personas contadas.
    var count: Int
    /// Intervalo para alertas (e.g., cada 10, 100 personas).
    var alertInterval: Int
    /// Inicializa el modelo con valores por defecto.
    /// - Parameters:
    ///   - count: Valor inicial del contador (por defecto 0).
    ///   - alertInterval: Intervalo para alertas (por defecto 10).
    init(count: Int = 0, alertInterval: Int = 10) {
        self.count = count
        self.alertInterval = alertInterval
    }
}
