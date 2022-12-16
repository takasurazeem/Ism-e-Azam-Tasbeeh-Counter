//
//  Ism_e_Azam.swift
//  Ism-e-Azam
//
//  Created by Takasur Azeem on 15/12/2022.
//

import WidgetKit
import SwiftUI

struct CounterEntry: TimelineEntry {
    let date = Date()
    private static let store = UserDefaults(suiteName: "group.Ism-e-Azam")
    @AppStorage("count", store: store) var count = 0
    @AppStorage("counterSize", store: store) var counterSize = 15
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> CounterEntry {
        CounterEntry()
    }

    func getSnapshot(in context: Context, completion: @escaping (CounterEntry) -> ()) {
        let entry = CounterEntry()
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entry = CounterEntry()

        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}


struct Ism_e_AzamEntryView: View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        if family == .systemSmall {
            return AnyView(Ism_e_AzamEntryViewSmall(entry: entry))
        }
        else if family == .systemMedium {
            return AnyView(Ism_e_AzamEntryViewMedium(entry: entry))
        } else {
            return AnyView(Ism_e_AzamEntryViewLarge(entry: entry))
        }
    }
}

struct Ism_e_AzamEntryViewSmall: View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack {
            Spacer()
            Text("\(entry.count)")
                .font(.largeTitle)
            Spacer()
            HStack {
                Button(role: .destructive) {
                    entry.count -= entry.counterSize
                } label: {
                    Image(systemName: "minus.square")
                }
                .buttonStyle(.borderedProminent)
                Spacer()
                Text("\(entry.counterSize)")
                Spacer()
                Button {
                    entry.count += entry.counterSize
                } label: {
                    Image(systemName: "plus.square")
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
    }
}

struct Ism_e_AzamEntryViewMedium: View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button(role: .destructive) {
                    entry.count -= entry.counterSize
                } label: {
                    Image(systemName: "minus.square")
                }
                .buttonStyle(.borderedProminent)
                
                Spacer()
                
                Text("\(entry.count)")
                    .font(.largeTitle)
                
                Spacer()
                
                Button {
                    entry.count += entry.counterSize
                } label: {
                    Image(systemName: "plus.square")
                }
                .buttonStyle(.borderedProminent)
            }
            Spacer()
            HStack {
                Text("Counter Size:")
                Text("\(entry.counterSize)")
            }
            .font(.footnote)
        }
        .padding()
    }
}

struct Ism_e_AzamEntryViewLarge: View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button(role: .destructive) {
                    entry.count -= entry.counterSize
                } label: {
                    Image(systemName: "minus.square")
                }
                .buttonStyle(.borderedProminent)
                
                Spacer()
                
                Text("\(entry.count)")
                    .font(.largeTitle)
                
                Spacer()
                
                Button {
                    entry.count += entry.counterSize
                } label: {
                    Image(systemName: "plus.square")
                }
                .buttonStyle(.borderedProminent)
            }
            Spacer()
            HStack {
                Text("Counter Size:")
                Text("\(entry.counterSize)")
            }
            .font(.footnote)
        }
        .padding()
    }
}


struct Ism_e_Azam: Widget {
    let kind: String = "Ism_e_Azam"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            Ism_e_AzamEntryView(entry: entry)
        }
        .configurationDisplayName("اسم اعظم")
        .description("Recite this 313 times and then make dua, will be accepted ان شاء اللہ تَعَالٰی.")
    }
}

struct Ism_e_Azam_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Ism_e_AzamEntryView(entry: CounterEntry())
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            Ism_e_AzamEntryView(entry: CounterEntry())
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            Ism_e_AzamEntryView(entry: CounterEntry())
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
