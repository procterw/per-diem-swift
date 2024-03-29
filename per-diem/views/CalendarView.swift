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
                ZStack {
                    Rectangle()
                        .fill(cardBackground(day: day))
                        .opacity(0.7)
                    Text(day.getDayOfMonth())
                        .font(.custom("SourceSerifPro-SemiBold", size: 14))
                }
                VStack {
                    VStack(spacing: 3) {
                        HStack(alignment: .top, spacing: 0) {
                            getActivity(index: 0)
                            getActivity(index: 1)
                        }
                        .frame(height: 26)
                        HStack(alignment: .top, spacing: 0) {
                            getActivity(index: 2)
                            getActivity(index: 3)
                        }
                        .frame(height: 22)
                    }
                    .padding(4)
                }
                .cornerRadius(5)
                .background(cardBackground(day: day))
                .frame(alignment: .top)
            }
        }
        .isDetailLink(false)
        .buttonStyle(PlainButtonStyle())
        .cornerRadius(5)
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
                                    .font(.custom("SourceSerifPro-Bold", size: 21))
                                    .padding(.vertical, 5)
                                Text(month.getYear())
                                    .font(.custom("SourceSerifPro-Regular", size: 17))
                                    .padding(.vertical, 5)
                            }
                            DayOfWeekLabels()
                                .padding(.vertical, 5)
                                .padding(.horizontal, 4)
                            ForEach(month.weeks) { week in
                                WeekRowView(week: week)
                            }
                        }
                        .padding(.horizontal, 6)
                        .padding(.bottom, 12)
                        .frame(maxWidth: 500)
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
            .scrollDismissesKeyboard(.immediately)
            
            ViewNav()
                .padding(.top, -8)
        }
    }
    
}
