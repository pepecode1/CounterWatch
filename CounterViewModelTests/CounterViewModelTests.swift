//
//  CounterViewModelTests.swift
//  CounterViewModelTests
//
//  Created by Pepe Ruiz on 21/09/25.
//
import XCTest
@testable import CounterWatch_Watch_App
/// Clase de pruebas unitarias para CounterViewModel.
final class CounterViewModelTests: XCTestCase {
    /// ViewModel bajo prueba.
    var viewModel: CounterViewModel!
    /// Configuración inicial para cada prueba.
    override func setUp() {
        super.setUp()
        viewModel = CounterViewModel(model: CounterModel(count: 0, alertInterval: 10))
    }
    /// Limpieza después de cada prueba.
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    /// Prueba que el contador se incremente correctamente.
    func testIncrementCount() {
        viewModel.incrementCount()
        XCTAssertEqual(viewModel.model.count, 1, "El contador debe incrementarse a 1")
        viewModel.incrementCount()
        XCTAssertEqual(viewModel.model.count, 2, "El contador debe incrementarse a 2")
    }
    /// Prueba que el contador no se decremente por debajo de 0.
    func testDecrementCount() {
        viewModel.decrementCount()
        XCTAssertEqual(viewModel.model.count, 0, "El contador no debe ser menor que 0")
        viewModel.incrementCount()
        viewModel.decrementCount()
        XCTAssertEqual(viewModel.model.count, 0, "El contador debe volver a 0")
    }
    /// Prueba que el intervalo de alerta se actualice correctamente.
    func testUpdateAlertInterval() {
        viewModel.updateAlertInterval(20)
        XCTAssertEqual(viewModel.model.alertInterval, 20, "El intervalo debe actualizarse a 20")
        viewModel.updateAlertInterval(0)
        XCTAssertEqual(viewModel.model.alertInterval, 20, "El intervalo no debe actualizarse si es 0")
    }
    /// Prueba que el intervalo se persista en UserDefaults.
    func testAlertIntervalPersistence() {
        viewModel.updateAlertInterval(50)
        let savedInterval = UserDefaults.standard.integer(forKey: "alertInterval")
        XCTAssertEqual(savedInterval, 50, "El intervalo debe guardarse en UserDefaults")
    }
    /// Prueba la lógica de múltiplo para alertas (sin probar vibración directamente).
    func testAlertIntervalTrigger() {
        viewModel.model.alertInterval = 5
        viewModel.model.count = 4
        viewModel.incrementCount()
        XCTAssertEqual(viewModel.model.count, 5, "El contador debe alcanzar el múltiplo 5")
    }
}
