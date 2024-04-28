# iOS Image Grid

## Overview
This project is an iOS application developed to efficiently load and display images in a scrollable grid. It utilizes Swift and native iOS technologies to implement features such as asynchronous image loading, caching mechanisms for both memory and disk, error handling, and smooth scrolling performance.

## Tasks
### Image Grid
- Displays a 3-column square image grid.
- Images are center-cropped for consistency.

### Image Loading
- Implements asynchronous image loading using a provided URL.
- Constructs image URLs using the fields of the thumbnail object from the API response.

### Display
- Users can scroll through at least 100 images.

### Caching
- Implements a caching mechanism to store images retrieved from the API in both memory and disk cache for efficient retrieval.

### Error Handling
- Gracefully handles network errors and image loading failures, providing informative error messages or placeholders for failed image loads.

## Implementation Details
- Developed in Swift using native iOS technologies.
- Images load lazily, and if a user quickly scrolls to another page, the loading for the previous page is cancelled in favor of the current page.
- Ensures smooth scrolling performance with no lag.

## Evaluation Criteria
- Images load lazily and smoothly.
- Scrolling through the image grid is lag-free.
- Both memory and disk caching work efficiently.
- Code compiles with the latest version of Xcode.

## Instructions to Run
1. Clone this repository to your local machine.
2. Open the project in Xcode.
3. Ensure you have the latest version of Xcode and Swift.
4. Build and run the project on a simulator or a physical iOS device.
5. Follow on-screen instructions to interact with the image grid.

