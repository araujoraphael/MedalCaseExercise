
# Medal Case App Challenge

## Overview

This app is designed to display a list of medals, with each medal representing a specific achievement. The app loads mocked data from a local JSON file (`medals.json`) and parses it into a data model defined in `MedalModelData`. The app provides a basic layout to showcase medals in a collection view, allowing users to scroll through the collection to view different medals.

### Key Features:
- **Mocked Data**: Loads medal data from a local JSON file (`medals.json`), providing a set of mocked medal information.
- **Collection View**: A main collection view is used to display the medals, showcasing their title, achievement, and an icon.
- **Medals Data Model**: The data is parsed using the `MedalModelData` model, defining the structure of the medals.
- **Section Header**: A section header view displays a page number indicator, which currently needs further updates.

---

## Areas of Improvement

While the app works with mocked data and provides a basic user experience, there are a few key areas that could be improved with additional time and resources:

### 1. **Image Caching**
   - Currently, there is no image caching implemented, as images are stored locally. Implementing a cache (using `NSCache` or a third-party library such as `SDWebImage` or `Kingfisher`) would significantly improve performance, especially when images are loaded repeatedly or when the app is used in a scenario with multiple images.

### 2. **Page Number Indicator**
   - The section header view has a page number indication, but it is not currently updated dynamically as the user scrolls. This feature might require additional effort due to the presence of nested collection views, which can cause scroll delegate conflicts. Properly updating the page number would improve the user experience when navigating through the collection.

### 3. **Scrolling Behavior**
   - Ideally, the medals collection view should not scroll or bounce vertically. Currently, vertical scrolling may be enabled, but this behavior can be refined. A fix to disable vertical scrolling or prevent vertical bouncing would create a more polished experience.

### 4. **Ellipsis Button**
   - A horizontal ellipsis button has been used for additional actions (e.g., settings or more options) due to its availability in SF Symbols. The vertical ellipsis button is not available in SF Symbols, so the horizontal ellipsis was chosen for consistency with available options.

### 5. **Unachieved Medals**
   - Medals that are "unachieved" should ideally be "greyed out" to improve the UX, indicating that they have not been earned yet. This would provide clearer visual feedback to users on their progress.

### 6. **Unit Testing**
   - At least `MedalCaseViewModel` and `MedalsUseCase` should be unit tested. Adding unit tests for the business logic in these components will help ensure stability and reliability, especially as the app grows and additional features are added.

---

## Considerations

- **Swift**: The app is developed using Swift.
- **UIKit**: The app uses UIKit for building the user interface, including collection views and other UI components in a mix of Storyboard, Xib and programmatically.
- **Xcode 16**: This project was created on Xcode 16. Please let me know if you find any build issues.
- **iOS Deployment Target**: The app requires a minimum deployment target of iOS 15.6.
- **Device Orientation**: The app is designed to run in portrait mode only on iPhone devices.

---

## Setup

To run this project on your local machine, follow these steps:

1. Clone this repository:
   ```bash
   git clone https://github.com/araujoraphael/MedalCaseExercise.git
   ```

2. Open the project in Xcode.

3. Build and run the project using the Xcode simulator or a connected device.

---
