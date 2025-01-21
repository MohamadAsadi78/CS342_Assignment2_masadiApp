# Assignment2_masadiApp

A simple **Electronic Health Record (EHR)** application built using **SwiftUI** and the new **`@Observable`** and **`@Environment`** APIs introduced in Swift 5.9. The app allows healthcare providers to manage patient records, including adding patients, viewing details, and prescribing medications.

---
### AI Usage

GPT-4o has been used to do the labor while I instructed it how to write the classes, what to include, and how to implement methods (e.g. which protocols to use, what the input output should be, what cases to handle and how to handle them, what functions to use in calculating date differences etc.)
https://chatgpt.com/share/6784cfee-1cf8-800a-9a4d-404160ba744f

---

## Features

### 1. **Patient List View**
- Displays all patients sorted alphabetically by last name.
- Includes a search bar to filter patients by last name.
- Tap on a patient to navigate to their **Patient Detail View**.
- Add new patients using the "Add Patient" button.

### 2. **New Patient Form**
- A form to add new patients to the system.
- Required fields: First name, Last name, Date of birth, Height, and Weight.
- Optional field: Blood type.
- Validation ensures that all required fields are filled before saving.

### 3. **Patient Detail View**
- Displays comprehensive information about an individual patient, including:
  - Full name, age, height, weight, and blood type.
  - A list of current medications (only active ones).
- Allows prescribing a new medication via a button that opens the **Prescribe Medication View**.

### 4. **Prescribe Medication View**
- A form to add medications to a patient's record.
- Required details: Name, Dose, Route, Frequency, and Duration.
- Prevents duplicate medications for a patient.
- Displays error messages if invalid or duplicate medications are added.

---

## Technology and Swift Features

- **SwiftUI**:
  - Modern declarative UI framework for building user interfaces.
- **`@Observable` and `@Environment` APIs**:
  - Simplified state management and dependency injection using Swift 5.9’s new macros.
  - Reduces boilerplate code and improves scalability.
- **Accessibility Identifiers**:
  - All fields and buttons are accessible for UI testing.
- **Responsive UI**:
  - Automatically updates views when state changes, thanks to `@Observable`.

