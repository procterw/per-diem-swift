//
//  IntroView.swift
//  per-diem
//
//  Created by William Leahy on 10/21/23.
//

import SwiftUI


class EstablishedViewModel: ObservableObject {
    @Published var isEstablished: Bool = false
}

struct ActivityList: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel: ActivityViewModel = ActivityViewModel()
    @FetchRequest(sortDescriptors: [])
    
    private var activityOptions: FetchedResults<ActivityOption>
    private var optionSuggestions: Array<Array<String>> = [
        ["👟", "Running"],
        ["📖", "Journal"],
        ["🏋️", "Workout"],
        ["🌞", "Gratitude"],
        ["🧘", "Meditation"],
        ["🚶🏻‍♀️", "Walking"],
        ["🎹", "Piano"],
        ["🐟", "Swimming"]
    ]
    
    func isSelected(icon: String, type: String) -> Bool {
        return activityOptions.first(where: {
            $0.icon == icon && $0.type == type
        }) != nil
    }
    
    func isSuggestion(opt: ActivityOption) -> Bool {
        return optionSuggestions.first(where: {
            $0[0] == opt.icon && $0[1] == opt.type
        }) != nil
    }
    
    func getList() -> Array<Array<String>> {
        var optionSuggestionsCopy = optionSuggestions
        activityOptions.forEach({ option in
            if (!isSuggestion(opt: option)) {
                optionSuggestionsCopy.append([
                    option.icon ?? "", option.type ?? ""
                ])
            }
        })
        
        return optionSuggestionsCopy
    }
    
    func handleAction(icon: String, type: String) {
        if (isSelected(icon: icon, type: type)) {
            let option = activityOptions.first(where: {
                $0.icon == icon && $0.type == type
            })
            do {
                viewContext.delete(option!)
                try viewContext.save()
            } catch {
                // Handle error
            }
        } else {
            let a = ActivityOption(context: viewContext)
            a.type = type
            a.icon = icon
            do {
                try viewContext.save()
                viewModel.reset()
            } catch {
                // Handle error
            }
        }
    }
    
    var body: some View {
        WrappedHStack(getList()) { suggestion in
            Button(action: {
                handleAction(icon: suggestion[0], type: suggestion[1])
            }) {
                HStack(spacing: 6) {
                    Text(suggestion[0])
                        .font(.custom("SourceSansPro-SemiBold", size: 18))
                    Text(suggestion[1])
                        .font(.custom("SourceSansPro-SemiBold", size: 15))
                        .foregroundColor(Color(.textDark))
                }
                .padding(.horizontal, 11)
                .padding(.vertical, 8)
            }
            .background(
                isSelected(icon: suggestion[0], type: suggestion[1])
                ? Color(.todayBackground)
                : Color(.cardBackground)
            )
            .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
        }
        .padding(.leading, -3)
    }
}

struct PageThreeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel: EstablishedViewModel = EstablishedViewModel()
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var activityOptions: FetchedResults<ActivityOption>

    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text(
                "Per-diem is a lightweight daily tracker for logging activities, tracking habits, and journaling.\n\nTo get started, add some categories you'd like to track; for example:")
                .font(.custom("SourceSerifPro-Regular", size: 16))
                .lineLimit(50)
                .padding(.top)

            ActivityList()
            
            ActivityOptionCreatorView()
            
            Divider()
                .padding(.vertical, 12)
            
            Button(action: {
                let a = Established(context: viewContext)
                a.isEstablished = true
                
                do {
                    try viewContext.save()
                } catch {
                    // Handle error
                }
            }) {
                Text("Get started")
            }
            .disabled(activityOptions.count < 1)
            .opacity(activityOptions.count > 0 ? 1 : 0.5)
            .padding(.vertical, 30)
            .frame(maxWidth: .infinity)
            .foregroundColor(Color(.textDark))
            .background(Color(.cardBackground))
            .font(.custom("SourceSansPro-SemiBold", size: 16))
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .padding()
    }
}
