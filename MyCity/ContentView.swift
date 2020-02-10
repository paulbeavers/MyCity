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

//-------------------------------------------------------------
// ContentView
//-------------------------------------------------------------
struct ContentView: View
{
    @State private var localCities = global.cities
    @State private var navBarHidden = true
    
    var body: some View {
        NavigationView {
            MasterView(cities: $localCities)
                .navigationBarTitle("")
                .navigationBarHidden(navBarHidden)
                .onAppear(perform: {self.navBarHidden = true})
                .onDisappear(perform: {self.navBarHidden = false})
        }
    }
}

//-------------------------------------------------------------
// MasterView
//-------------------------------------------------------------
struct MasterView: View {
    @Binding var cities: [String]
    @State var showSheet:Bool = false
    var body: some View {
        VStack {
            HStack {
                EditButton()
                    .padding()
                Spacer()
                Text("My Cities")
                    .font(.system(size: 36))
                    .bold()
                Spacer()
                Button(action: {
                    self.showSheet.toggle()
                }) {
                    Image(systemName: "plus")
                    .padding()
                }.sheet(isPresented: $showSheet) {
                    AddCityDialog(showingSheet: self.$showSheet, cities: self.$cities)
                }
            }
            List {
                ForEach(self.cities, id: \.self) { city in
                    NavigationLink(
                        destination: DetailView( selectedCity: city)
                    ) {
                        VStack {
                            Text(city)
                        }
                    }
                }.onDelete { indices in
                    indices.forEach {
                        self.cities.remove(at: $0)
                        global.cities.remove(at: $0)
                    }
                }
            }
        }
    }
}

//-------------------------------------------------------------
// Detail View
//-------------------------------------------------------------
struct DetailView: View {
    var selectedCity: String
    var body: some View {
        Group {
            Text(selectedCity)
            Text("time zone")
        }.navigationBarTitle("")
        .navigationBarHidden(false)
    }
}

//-------------------------------------------------------------
// AddCityDialog
//-------------------------------------------------------------
struct AddCityDialog: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var showingSheet: Bool
    @Binding var cities: [String]
    @State private var name: String = ""
    var body: some View {
        VStack {
            Text("Ohay!")
            TextField("City", text: $name)
            Button("Save") {
                self.cities.append(self.name)
                global.cities.append(self.name)
                self.presentationMode.wrappedValue.dismiss()
            }
            Button("Cancel") {
                           self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

//-------------------------------------------------------------
// ContentView_Previews
//-------------------------------------------------------------
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
