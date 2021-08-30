//
//  nano06Widget.swift
//  nano06Widget
//
//  Created by IgorMiyamoto on 24/08/21.
//

import WidgetKit
import SwiftUI

//struct Provider: IntentTimelineProvider {
//    func placeholder(in context: Context) -> SimpleEntry {
//        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
//    }
//
//    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
//        let entry = SimpleEntry(date: Date(), configuration: configuration)
//        completion(entry)
//    }
//
//    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//        var entries: [SimpleEntry] = []
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, configuration: configuration)
//            entries.append(entry)
//        }
//
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        completion(timeline)
//    }
//}
//
//struct SimpleEntry: TimelineEntry {
//    let date: Date
//    let configuration: ConfigurationIntent
//}

struct SpriteView : View {
    var spriteName : String
    var body: some View {
        ZStack {
            Color(.displayP3, red: 242/255, green: 232/255, blue: 125/255, opacity: 1).ignoresSafeArea()
                        
            Image(spriteName)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

struct SpriteEntry: TimelineEntry {
    let date: Date
    let imgName : String
}

struct Provider : TimelineProvider {
    
//    @AppStorage("sede", store: UserDefaults(suiteName: "group.com.developerAcademy.challenge.NanoChallenge06"))
//    var sede : Bool = false
    
    func placeholder(in context: Context) -> SpriteEntry {
        SpriteEntry(date: Date(), imgName: "parado0")
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SpriteEntry) -> Void) {
        completion(SpriteEntry(date: Date(), imgName: "parado0"))
    }
    
    //Puxar nova data e afalar pro widget att
    func getTimeline(in context: Context, completion: @escaping (Timeline<SpriteEntry>) -> Void) {
        let now = Date()
        //"dead_3" : "idle_1"
//        var entries : [SpriteEntry] = []
//        for minuteOffset in (0..<3) {
//            let entryDate = Calendar.current.date(byAdding: .second, value: minuteOffset, to: now)!
//            let entry = SpriteEntry(date: entryDate, imgName: (minuteOffset % 2 == 0) ? "dead_3" : "idle_1")
//            entries.append(entry)
//        }
        
        let entry = SpriteEntry(date: now, imgName: "parado0")
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
    
    typealias Entry = SpriteEntry
    
}

struct PlaceholderView : View {
    var body: some View {
        SpriteView(spriteName: "idle_1")
    }
}

struct nano06WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        SpriteView(spriteName: entry.imgName)
    }
    
}

@main
struct nano06Widget : Widget {
    private let kind = "Widget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            nano06WidgetEntryView(entry: entry)
        }
    }

}

//@main
//struct nano06Widget: Widget {
//    let kind: String = "nano06Widget"
//
//    var body: some WidgetConfiguration {
//        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
//            nano06WidgetEntryView(entry: entry)
//        }
//        .configurationDisplayName("My Widget")
//        .description("This is an example widget.")
//    }
//}
//
//struct nano06Widget_Previews: PreviewProvider {
//    static var previews: some View {
//        nano06WidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
