//
//  MainView.swift
//  per-diem
//
//  Created by William Leahy on 2/24/23.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var activeView: ActiveView
    @FetchRequest(sortDescriptors: [])
    private var options: FetchedResults<Established>

    var body: some View {
        ZStack {
            Color("AppBackground")
            VStack {
                if (options.count > 0) {
                    switch activeView.active {
                    case "list":
                        DayListView()
                    case "calendar":
                        CalendarView()
                    default:
                        Text("ERROR")
                    }
                } else {
                    IntroView()
                }
            }
        }
    }
}


//
//  MainView.swift
//  per-diem
//
//  Created by William Leahy on 2/24/23.
//
//
//import SwiftUI
//import CoreData
//
//struct MainView: View {
//    @EnvironmentObject private var activeView: ActiveView
//    @State private var isUserEstablished = UserDefaults.standard.bool(forKey: "IsEstablished")
//    
//    var body: some View {
//        ZStack {
//            Color("AppBackground")
//            VStack {
//                switch isUserEstablished {
//                    case false:
//                        IntroPage()
//                    default: switch activeView.active {
//                        case "list":
//                            DayListView()
//                        case "calendar":
//                            CalendarView()
//                        default:
//                            Text("ERROR")
//                        }
//                }
//            }
//        }
//    }
//}
