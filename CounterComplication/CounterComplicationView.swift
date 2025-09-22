//
//  CounterComplicationView.swift
//  CounterWatch
//
//  Created by Pepe Ruiz on 21/09/25.
//
import SwiftUI
import WidgetKit
/// Vista de la complicación que muestra el conteo actual.
struct CounterComplicationView: View {
    /// Modelo del contador para mostrar el conteo.
    let model: CounterModel
    var body: some View {
        Text("\(model.count)")
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(.white)
            .containerBackground(.fill.tertiary, for: .widget)
    }
}
/// Proveedor de timeline para actualizar la complicación periódicamente.
struct CounterComplicationProvider: TimelineProvider {
    /// Suite de UserDefaults compartida con App Group.
    private let userDefaults = UserDefaults(suiteName: "group.com.pepecode.counterwatch")
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), model: CounterModel(count: 0))
    }
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let count = userDefaults?.integer(forKey: "currentCount") ?? 0
        let entry = SimpleEntry(date: Date(), model: CounterModel(count: count))
        completion(entry)
    }
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        let currentDate = Date()
        let count = userDefaults?.integer(forKey: "currentCount") ?? 0
        let model = CounterModel(count: count)
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, model: model)
            entries.append(entry)
        }
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
/// Entry para el timeline de la complicación.
struct SimpleEntry: TimelineEntry {
    let date: Date
    let model: CounterModel
}
/// Configuración principal de la complicación.
struct CounterComplication: Widget {
    let kind: String = "CounterComplication"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CounterComplicationProvider()) { entry in
            CounterComplicationView(model: entry.model)
        }
        .configurationDisplayName("Contador")
        .description("Muestra el conteo actual.")
        .supportedFamilies([.accessoryCircular, .accessoryCorner, .accessoryRectangular])
    }
}
