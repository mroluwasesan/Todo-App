//
//  ContentView.swift
//  Todo App
//
//  Created by Negatron on 29/05/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    

    //    @Environment(\.managedObjectContext) private var viewContext
    //
    //    @FetchRequest(
    //        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
    //        animation: .default)
    //    private var items: FetchedResults<Item>
    
    //    private func addItem() {
    //        withAnimation {
    //            let newItem = Item(context: viewContext)
    //            newItem.timestamp = Date()
    //
    //            do {
    //                try viewContext.save()
    //            } catch {
    //
    //                let nsError = error as NSError
    //                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    //            }
    //        }
    //    }
    //
    //    private func deleteItems(offsets: IndexSet) {
    //        withAnimation {
    //            offsets.map { items[$0] }.forEach(viewContext.delete)
    //
    //            do {
    //                try viewContext.save()
    //            } catch {
    //
    //                let nsError = error as NSError
    //                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    //            }
    //        }
    //    }
    //}
    //
    //private let itemFormatter: DateFormatter = {
    //    let formatter = DateFormatter()
    //    formatter.dateStyle = .short
    //    formatter.timeStyle = .medium
    //    return formatter
    //}()
    
    // MARK: - PROPERTIES
    @State private var showingAddTodoView: Bool = false
    // MARK: - BODY
    var body: some View {
        
        NavigationView {
            List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                Text("Hello")
                
            }//:LIST
            .navigationBarTitle("Todo", displayMode: .inline)
            .navigationBarItems(trailing:
            Button(action: {
                //: Show add todo view
                self.showingAddTodoView.toggle()
            }){
                Image(systemName: "plus")
            }//:ADD BUTTON
                .sheet(isPresented: $showingAddTodoView){
                    AddTodoView()
                }
            )
        }//: NAVIGATION
    }
}
    


// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
