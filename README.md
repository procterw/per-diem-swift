# Per-Diem

Per-diem is a feature-light daily tracker for logging activities, journaling, and tracking progress. Start by creating a list of categories you wish you track. This can range from tracking which days and how far you go running to keeping a daily journal.

Per-diem's UX and technical design is driven by three principals:
 - Logging the occurance of an activity is more important than details, so it should be as frictionless as possible to do that.
 - For most people, the best way to track growth is consistency. Therefore, day-to-day consistency and looking through old entries is more important than metrics or data that require more complex data entry.
 - Creating more accounts and trusting additional parties with your data is not great, which is why this app is iOS only and makes use of the Core Data APIs and iCloud.

# Take a Tour!

## App Onboarding

This view aims to introduce the purpose of the app as well as the concept of categories and the emoji symbol system. Once a user has selected or create one or more categories they will be directed to the daily calendar view.

<img width="300" alt="x" src="https://github.com/procterw/per-diem-swift/assets/2933352/c389e5bf-6f58-40b5-bed1-804d106bec73">
<img width="300" alt="x" src="https://github.com/procterw/per-diem-swift/assets/2933352/02451ef8-2a98-44b6-b8e1-94e343cf8fb1">

## Daily calendar

This is the main view of the application, as well as where users are taken when they click on reminder notifications. Each day in the calendar shows all the type associated activities, as well as a short preview of the entry's text. The purpose of this view is mostly to see a recent log of activity as well as click into days to add entries. All views have the same filter and search bar, and queries follow you from view to view.

<img width="300" alt="x" src="https://github.com/procterw/per-diem-swift/assets/2933352/380dc23b-400b-4c46-a60e-2570bf6dd77c">

## Monthly calendar

The calendar view is useful for checking in on how consistently you've been doing something or look at trends in activity.

<img width="300" alt="x" src="https://github.com/procterw/per-diem-swift/assets/2933352/1083c583-a1f8-4b29-adee-f8f08db786b1">

## Stream view

In this view you can read through all entries you've made, and filter that based on category.

<img width="300" alt="x" src="https://github.com/procterw/per-diem-swift/assets/2933352/edaf43db-3a7c-4a16-a8f7-fb64f3281b0c">

## Add Activities to a Day

When you open a day, click the buttons to add entries, then optionally add text for each one.

<img width="300" alt="x" src="https://github.com/procterw/per-diem-swift/assets/2933352/488bf4cf-9011-4d0f-8bdd-92dc0e47d9df">
<img width="300" alt="x" src="https://github.com/procterw/per-diem-swift/assets/2933352/10d67c62-8889-4d42-bafc-cdeff96f18f5">

## Settings (Manage categories, set notifications)

<img width="300" alt="x" src="https://github.com/procterw/per-diem-swift/assets/2933352/d5724080-6084-46a8-8b51-228b194ed079">



