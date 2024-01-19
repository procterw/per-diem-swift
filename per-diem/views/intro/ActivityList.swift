//
//  OptionSuggestions.swift
//  per-diem
//
//  Created by William Leahy on 1/15/24.
//

import SwiftUI

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
            .transition(.slide)
        }
        .padding(.leading, -3)
    }
}
