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
    @State var selectedDate:Date = Date()
    @State var selection:Bool = false

    var body: some View {
        ZStack{
            CalendarRepresentable(selectedDate: $selectedDate, selection: $selection)
                .background(Color.beigeColor)
            NavigationLink(
                destination: CanvasEditor(selectedDate: $selectedDate),
                isActive: $selection,
                label: {
                })
        }
        
       
    }
}

struct CalendarRepresentable:UIViewRepresentable{
    typealias UIViewType = FSCalendar
    var calendar = FSCalendar()
    @Binding var selectedDate: Date
    @Binding var selection:Bool
    
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
            print(String(parent.selectedDate.description))
            parent.selection.toggle()
            
            
            //ir para a pagina do dia
        }
        func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
            let cell = calendar.dequeueReusableCell(withIdentifier: "CELL", for: date, at: position)
            cell.imageView.contentMode = .scaleAspectFit
            cell.imageView.tintColor = .black
            //customizar célula de cada data
            
            return cell
        }
//        func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//            return 1
//        }
//        func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
//            //retorna uma imagem para uma célula
//            return UIImage(systemName: "pencil.circle")
//        }
       
    }
    
    
    
    
}
struct Calendar_Previews: PreviewProvider {
    static var previews: some View {
        Calendar()
    }
}
