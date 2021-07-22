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

    var body: some View {
        
        CalendarRepresentable(selectedDate: $selectedDate)
            .background(Color.beigeColor)
    }
}

struct CalendarRepresentable:UIViewRepresentable{
    typealias UIViewType = FSCalendar
    var calendar = FSCalendar()
    @Binding var selectedDate: Date
    
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
       
        return calendar
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource{
        var parent: CalendarRepresentable
        
        init(_ parent: CalendarRepresentable){
            self.parent = parent
        }
        
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            parent.selectedDate = date
        }
    }
    
    
    
    
}
struct Calendar_Previews: PreviewProvider {
    static var previews: some View {
        Calendar()
    }
}
