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

    let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()

    var body: some View {
        
        NavigationView {
            if(reminders.count == 0)
            {
                Text("Aucun rappel")
                    .navigationBarTitle("Rappel")
                    .toolbar {
                        ToolbarItemGroup(placement: .bottomBar) {
                            Button {
                                self.showingAddItem.toggle()
                            } label : {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }
                        }
                    }
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
                            VStack(alignment: .leading) {
                                Text("\(reminder.title)")
                                if (!reminder.notes.isEmpty) {
                                    Text("\(reminder.notes)")
                                        .font(.footnote)
                                        .foregroundColor(Color.gray)
                                }
                                if (reminder.isDate) {
                                    Text("\(reminder.date, formatter: dayFormatter)")
                                        .font(.footnote)
                                        .foregroundColor(Color.gray)
                                }
                                if (reminder.isHour) {
                                    Text("\(reminder.hour, formatter: timeFormatter)")
                                        .font(.footnote)
                                        .foregroundColor(Color.gray)
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteItem(at:))
                }
                .navigationBarTitle("Rappel")
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        Button {
                            self.showingAddItem.toggle()
                        } label : {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                    }
                }
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

