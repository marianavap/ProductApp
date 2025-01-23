# Product App

A simple SwiftUI application that fetches and displays a list of products from an external API. The app follows the **MVVM (Model-View-ViewModel)** architecture to ensure scalability, testability, and a clean codebase.

---

## Features

1. **Product List**:
   - Displays a list of products with their title, rating, and category.
   - Implements loading and error states.
   - Dynamic icons for ratings (`<3`, `3-4`, `>4`).

2. **Product Detail**:
   - Displays detailed information about a selected product, including:
     - Price
     - Discount Percentage
     - Stock Availability

3. **Clean Architecture**:
   - **MVVM Pattern** with separation of responsibilities between Model, View, and ViewModel.
   - Reusable components like `ProductRowView`.

---

## Requirements

- **iOS 18.0+**
- **Swift 5+**
- **Xcode 16.2+**

