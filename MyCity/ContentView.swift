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

struct ContentView: View
{
    @State private var localCities = global.cities
    
    var body: some View {
        
        NavigationView {
            MasterView(cities: $localCities)
                .navigationBarTitle(Text("My Cities"))
                .navigationBarItems(
                    leading: EditButton()
                )
        }.navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

struct MasterView: View {
    @Binding var cities: [String]
    @State var showSheet:Bool = false
    var body: some View {
        VStack {
            
                Button(action: {
                    self.showSheet.toggle()
                }) {
                    Image(systemName: "plus")
                }.sheet(isPresented: $showSheet) {
                    AddCityDialog(showingSheet: self.$showSheet, cities: self.$cities)
                }
            
        
            List {
                ForEach(self.cities, id: \.self) { city in
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
                    indices.forEach { self.cities.remove(at: $0) }
                }
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

struct AddCityDialog: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var showingSheet: Bool
    @Binding var cities: [String]
    var body: some View {
        VStack {
            Text("Ohay!")
            Button("Close") {
                self.cities.append("Untitled")
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
