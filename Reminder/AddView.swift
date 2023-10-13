//
//  AddView.swift
//  Reminder
//
//  Created by Thibault Giraudon on 13/10/2023.
//

import SwiftUI

struct AddView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var notes = ""
    @State private var isDone = false
    @State private var isAlert = false
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Titre", text: $title)
                    TextField("Notes", text: $notes)
                }
            }
            .navigationBarItems(
                leading: Button(action: {dismiss()}) {
                    Text("Annuler")
                },
                trailing: Button(action: {Add()} ) {
                    Text("Ajouter")
                })
            .navigationBarTitle("Nouveau Rappel")
            .alert(isPresented: $isAlert) { () -> Alert in
                Alert(title: Text("Erreur"), message: Text("Le champs \"Titre\" ne doit pas rester vide"), dismissButton: .default(Text("Ok")))}
        }
    }
    
    private func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    private func Add() {
        if title == ""
        {
            isAlert = true
            return
        }
        let newReminder = Reminder(context: self.viewContext)
        newReminder.title = title
        newReminder.notes = notes
        newReminder.isDone = isDone
        do {
            try self.viewContext.save()
        } catch {
            print("whoops \(error.localizedDescription)")
        }
        self.presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    AddView()
}
