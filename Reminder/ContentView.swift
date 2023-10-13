//
//  ContentView.swift
//  Reminder
//
//  Created by Thibault Giraudon on 13/10/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Reminder.title, ascending: true)],
        animation: .default)
    private var reminders: FetchedResults<Reminder>
    @State private var showingAddItem = false
    private var nb_done = 0

    var body: some View {
        NavigationView {
            if(reminders.isEmpty)
            {
                Text("Aucun rappel")
                    .navigationBarTitle("Rappel")
                    .navigationBarItems(leading: EditButton(),
                                        trailing: Button("Add") {
                        self.showingAddItem.toggle()
                    })
                    .sheet(isPresented: $showingAddItem) {
                        AddView().environment(\.managedObjectContext, self.viewContext)
                    }
            }
            else {
                List {
                    ForEach(reminders, id : \.self) { reminder in
                        HStack {
                            Button {
                                reminder.isDone.toggle()
                            } label: {
                                Image(systemName: reminder.isDone ? "largecircle.fill.circle" : "circle")
                                    .foregroundColor(reminder.isDone ? .blue : .gray)
                            }
                            VStack {
                                Text("\(reminder.title)")
                                Text("\(reminder.notes)")
                                    .font(.footnote)
                                    .foregroundColor(Color.gray)
//                                    .multilineTextAlignment(.leading)
                            }
                        }
                    }
                    .onDelete(perform: deleteItem(at:))
                }
                .navigationBarTitle("Rappel")
                .navigationBarItems(leading: EditButton(),
                                    trailing: Button("Add") {
                    self.showingAddItem.toggle()
                })
                .sheet(isPresented: $showingAddItem) {
                    AddView().environment(\.managedObjectContext, self.viewContext)
                }
            }
        }
    }

    
    func deleteItem(at offsets: IndexSet) {
        for index in offsets {
            let reminder = reminders[index]
            viewContext.delete(reminder)
        }
    }
}


#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

