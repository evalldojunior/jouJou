//
//  Calendar.swift
//  jouJou
//
//  Created by Dara Caroline on 22/07/21.
//

import Foundation
import SwiftUI
import UIKit
import FSCalendar


struct Calendar: View {
    @State var selectedDate:Date? = Date()
    @State var selection:Bool = false
    @State var index:Int = 0
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Humores.entity(), sortDescriptors: []) var humores: FetchedResults<Humores>
    @FetchRequest(entity: Anotacao.entity(), sortDescriptors: []) var anotacoes: FetchedResults<Anotacao>

    

    var body: some View {
        ZStack{
            CalendarRepresentable(selectedDate: $selectedDate, selection: $selection,anotacaoIndex: $index, humores:humores, anotacoes: anotacoes)
                .background(Color.beigeColor)
        
            NavigationLink(
                destination: CanvasEditor(anotacao: anotacoes[index]),
                isActive: $selection,
                label: {
                })
        }
        
       
    }
}

struct CalendarRepresentable:UIViewRepresentable{
    typealias UIViewType = FSCalendar
    var calendar = FSCalendar()

    @Binding var selectedDate: Date?
    @Binding var selection:Bool
    @Binding var anotacaoIndex:Int
    var humores:FetchedResults<Humores>
    var anotacoes:FetchedResults<Anotacao>
    
    func updateUIView(_ uiView: FSCalendar, context: Context) {
        
    }
    func makeUIView(context: Context) -> FSCalendar {
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
        
        //customiza o calendário aqui
        calendar.appearance.headerTitleColor = UIColor(.blackColor)
        calendar.appearance.headerTitleFont = UIFont(name: "LibreBaskerville-Regular", size: 36)
        calendar.backgroundColor = UIColor(.beigeColor)
        calendar.appearance.todayColor = UIColor(.lightSalmonColor)
        calendar.appearance.weekdayFont = UIFont(name: "Raleway-Bold", size: 24)
        calendar.appearance.weekdayTextColor = UIColor(.darkSalmonColor)
        calendar.appearance.titleFont = UIFont(name: "Raleway-Bold", size: 24)
        calendar.appearance.selectionColor = UIColor(.darkSalmonColor)
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        return calendar
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource{
        var parent: CalendarRepresentable
        
        init(_ parent: CalendarRepresentable){
            self.parent = parent
            self.parent.calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "CELL")
        }
        
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            parent.selectedDate = date
            let dateFormatter = DateFormatter()

            dateFormatter.dateFormat = "dd/MM/YY"
            for (index, anotacao) in parent.anotacoes.enumerated(){
                if dateFormatter.string(from: anotacao.dia!) == dateFormatter.string(from: parent.selectedDate!){
                    parent.anotacaoIndex = index
                    parent.selection.toggle()
                    
                }
            }
           // print(String(parent.selectedDate.description))
            
            
            
            //ir para a pagina do dia
        }
        func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
            let cell = calendar.dequeueReusableCell(withIdentifier: "CELL", for: date, at: position)
            cell.imageView.contentMode = .scaleAspectFit
            cell.imageView.tintColor = .black
            //customizar célula de cada data
            
            return cell
        }
        func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
            let dateFormatter = DateFormatter()

            dateFormatter.dateFormat = "dd/MM/YY"

            for humor in parent.humores{
                if dateFormatter.string(from: date) == dateFormatter.string(from: humor.dia!) {
                    return 1
                }
            }
            return 0
        }
//        func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
//            //retorna uma imagem para uma célula
//            if (calendar.){
//
//            }
//            return UIImage(systemName: "pencil.circle")
//        }
//
    }
    
    
    
    
}
