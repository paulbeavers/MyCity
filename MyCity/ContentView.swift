//
//  ContentView.swift
//  MyCity
//
//  Created by Paul Beavers on 2/1/20.
//  Copyright © 2020 Paul Beavers. All rights reserved.
//

import SwiftUI

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .medium
    return dateFormatter
}()

struct ContentView: View {@State private var cities = [String]()
    var body: some View {
        NavigationView {
            MasterView()
                .navigationBarTitle(Text("My Cities"))
                .navigationBarItems(
                    leading: EditButton(),
                    trailing: Button(
                        action: {
                          //  withAnimation { self.dates.insert(Date(), at: 0) }
                        }
                    ) {
                        Image(systemName: "plus")
                    }
                )
            DetailView(selectedCity: "")
        }.navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

struct MasterView: View {
    var body: some View {
        List {
            ForEach(global.cities, id: \.self) { city in
                NavigationLink(
                    destination: DetailView(selectedCity: city)
                ) {
                    VStack {
                    Text(city)
                    Text("tz")
                        Text("tz")
                        Text("tz")
                        Image(systemName: "plus")
                    }
                }
            }.onDelete { indices in
                indices.forEach { global.cities.remove(at: $0) }
            }
        }
    }
}

struct DetailView: View {
    var selectedCity: String

    var body: some View {
        Group {
            Text(selectedCity)
            Text("time zone")
        }.navigationBarTitle(Text(selectedCity))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
