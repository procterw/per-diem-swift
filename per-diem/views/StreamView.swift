//
//  LogView.swift
//  per-diem
//
//  Created by William Leahy on 2/28/23.
//

import SwiftUI

struct StreamItem: View {
    var activity: Activity
    var day: DayItem
    
    init(activity: Activity) {
        self.activity = activity
        self.day = dayItemFromId(dateId: activity.dateId)
    }
    
    var body: some View {
        ZStack {
            NavigationLink(destination:
                EntryView(day: day)
                    .toolbarBackground(Color("ViewBackground"), for: .navigationBar)
            ) {
                EmptyView()
            }
            .opacity(0.0)
            .buttonStyle(PlainButtonStyle())

            HStack {
                VStack(alignment: .leading, spacing: 7) {
                        HStack(spacing: 4) {
                        Text(activity.option?.icon ?? "")
                            .font(.title2)
                        Text(activity.option?.type ?? "")
                            .font(.custom("SourceSansPro-Semibold", size: 16))
                            .fontWeight(.semibold)
                    }
                    Text(day.getFullDate())
                        .font(.custom("SourceSerifPro-Semibold", size: 15))
                    Text(activity.note ?? "")
                }
                .frame(
                      minWidth: 0,
                      maxWidth: .infinity,
                      minHeight: 0,
                      maxHeight: .infinity,
                      alignment: .topLeading
                    )
                .padding()
                .background(cardBackground(day: day))
            }
            .padding(.top, 1)
        }
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
}

struct ActivityStreamList: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest var activities: FetchedResults<Activity>
    @EnvironmentObject private var activityFilter: ActivityFilter
    
    var searchTerm: String
    
    init(searchTerm: String) {
        self.searchTerm = searchTerm
        
        var subpredicates: Array<NSPredicate> = []
        
        if (searchTerm.count > 0) {
            subpredicates.append(NSPredicate(format: "note CONTAINS[c] %@", searchTerm))
        }
        
        _activities = FetchRequest<Activity>(
            sortDescriptors: [NSSortDescriptor(keyPath: \Activity.dateId, ascending: false)],
            predicate: NSCompoundPredicate(
                type: .and,
                subpredicates: subpredicates
            )
        )
    }
    
    func delete(activity: Activity) {
        do {
            viewContext.delete(activity)
            try viewContext.save()
        } catch {
            // Handle error
        }
    }
    
    var body: some View {
        VStack {
            List() {
                ForEach(activities.filter {
                    if (activityFilter.selected.isEmpty) {
                        return true
                    } else {
                        return activityFilter.selected.contains($0.option?.type ?? "")
                    }
                }) { activity in
                    StreamItem(activity: activity)
                        .listRowInsets(EdgeInsets())
                        .swipeActions {
                            Button("Delete") {
                                delete(activity: activity)
                            }
                            .tint(.red)
                        }
                }
            }
            .listStyle(.plain)
            .background(Color("ViewBackground"))
            .scrollContentBackground(.hidden)
        }
    }
}

struct StreamView: View {
    @EnvironmentObject private var searchTerm: SearchTerm
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("ViewBackground")
                VStack {
                    TopNavbar()
                        .padding(.bottom, -8)
                    
                    ActivityStreamList(searchTerm: searchTerm.term)
                    
                    ViewNav()
                        .padding(.top, -8)
                }
            }
        }
    }
}
