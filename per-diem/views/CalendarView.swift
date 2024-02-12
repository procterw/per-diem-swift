//
//  CalendarView.swift
//  per-diem
//
//  Created by William Leahy on 2/24/23.
//
import SwiftUI

struct DayCell: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest var activities: FetchedResults<Activity>
    @EnvironmentObject private var activityFilter: ActivityFilter
    
    var day: DayItem
    var searchTerm: String

    init(day: DayItem, searchTerm: String) {
        self.day = day;
        self.searchTerm = searchTerm;

        var subpredicates: Array<NSPredicate> = [
            NSPredicate(format: "dateId == %d", day.dateId)
        ]
        
        if (searchTerm.count > 0) {
            subpredicates.append(NSPredicate(format: "note CONTAINS[c] %@", searchTerm))
        }
        
        _activities = FetchRequest<Activity>(
            sortDescriptors: [NSSortDescriptor(keyPath: \Activity.option?.count, ascending: false)],
            predicate: NSCompoundPredicate(
                type: .and,
                subpredicates: subpredicates
            )
        )
    }
    
    func getActivity(index: Int) -> some View {
        let filteredActivites = activities.filter {
            if (activityFilter.selected.isEmpty) {
                return true
            } else {
                return activityFilter.selected.contains($0.option?.type ?? "")
            }
        }
        if (filteredActivites.count < index + 1) {
            return Text("").frame(maxWidth: .infinity)
        }
        return Text(filteredActivites[index].option?.icon ?? "").frame(maxWidth: .infinity)
    }
    
    var body: some View {
        NavigationLink(destination:
            EntryView(day: day)
        ) {
            VStack(spacing: 0) {
                Group {
                    VStack(spacing: 3) {
                        HStack(alignment: .top, spacing: 0) {
                            Text(day.getDayOfMonth())
                                .font(.custom("SourceSansPro-SemiBold", size: 14))
                                .frame(maxWidth: .infinity)
                            getActivity(index: 0)
                        }
                        HStack(alignment: .top, spacing: 0) {
                            getActivity(index: 1)
                            getActivity(index: 2)
                        }
                    }
                    .padding(4)
                    .cornerRadius(5)
                    .frame(height: 55, alignment: .top)
                }
                .background(cardBackground(day: day))
            }
        }
        .isDetailLink(false)
        .buttonStyle(PlainButtonStyle())
        .cornerRadius(3)
    }
}

struct WeekRowView: View {
    @EnvironmentObject private var searchTerm: SearchTerm

    var week: Week
    
    var body: some View {
        GridRow(alignment: .top) {
            if (week.offset > 0) {
                Color.clear
                    .gridCellUnsizedAxes([.horizontal, .vertical])
                    .gridCellColumns(week.offset)
            }
            ForEach(week.days) { day in
                DayCell(day: day, searchTerm: searchTerm.term)
            }
        }
    }
}

struct DayOfWeekLabels: View {
    private let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    var body: some View {
        HStack() {
            ForEach(days, id: \.self) { day in
                Text(day)
                    .frame(maxWidth: .infinity)
                    .font(.custom("SourceSansPro-SemiBold", size: 13))
            }
        }
    }
}

struct CalendarView: View {
    @ObservedObject var calendar: PDCalendar = PDCalendar()

    var body: some View {
        NavigationStack {
            TopNavbar()
                .padding(.bottom, -8)

            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(calendar.months) { month in
                        Grid(horizontalSpacing: 1, verticalSpacing: 1) {
                            HStack(alignment: .firstTextBaseline) {
                                Text(month.getMonthName())
                                    .font(.custom("SourceSerifPro-Black", size: 22))
                                    .padding(.vertical, 5)
                                Text(month.getYear())
                                    .font(.custom("SourceSerifPro-Regular", size: 16))
                                    .padding(.vertical, 5)
                            }
                            DayOfWeekLabels()
                                .padding(.vertical, 5)
                            ForEach(month.weeks) { week in
                                WeekRowView(week: week)
                            }
                        }
                        .padding(.horizontal, 6)
                        .padding(.bottom, 12)
                        .rotationEffect(Angle(degrees: 180))
                        .scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                        .onAppear {
                            calendar.loadMore(month: month)
                        }
                    }
                }
            }
            .rotationEffect(Angle(degrees: 180))
            .scaleEffect(x: -1.0, y: 1.0, anchor: .center)
            .background(Color("ViewBackground"))
            
            ViewNav()
                .padding(.top, -8)
        }
    }
    
}
