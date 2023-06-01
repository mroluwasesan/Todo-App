//
//  ContentView.swift
//  Todo App
//
//  Created by Negatron on 29/05/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)],
        animation: .default)
    private var todos: FetchedResults<Todo>
    
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
        private func deleteTodo(offsets: IndexSet) {
            withAnimation {
                offsets.map { todos[$0] }.forEach(viewContext.delete)
    
                do {
                    try viewContext.save()
                } catch {
    
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
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
            ZStack {
                List {
                    ForEach(self.todos, id:\.self){todo in
                        HStack{
                            Text(todo.name ?? "Unkown")
                            
                            Spacer()
                            
                            Text(todo.priority ?? "Unkown")
                        }//:HSTACK
                    }//:FOREACH
                    .onDelete(perform: deleteTodo(offsets:))
                }//:LIST
                .navigationBarTitle("Todo", displayMode: .inline)
                .navigationBarItems(leading: EditButton(),trailing:
                                        Button(action: {
                    //: Show add todo view
                    self.showingAddTodoView.toggle()
                }){
                    Image(systemName: "plus")
                }//:ADD BUTTON
                    .sheet(isPresented: $showingAddTodoView){
                        AddTodoView().environment(\.managedObjectContext, self.viewContext)
                    }
            )
                
            // MARK: - NO TODO ITEM
                if todos.count == 0 {
                    EmptyListView()
                }
            }//: ZSTACK
        }//: NAVIGATION
    }
}



// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
