# PhotoshoppedFaceDetection_APP (PurePixel app)

## Project Description

PurePixel is a mobile application built with Flutter that allows users to detect edited parts on facial images using AI technology.


## Features

- **Image Analysis:** Accepts image uploads via a RESTful API.
- **Detection:** Pass the image to a semantic segmentation model to detect edited areas on face (using custom UNet model).
- **Visualization:** Returns results with a heatmap highlighting the edited regions.

## Technologies Used


PurePixel is built using modern technologies to provide a seamless experience for image analysis and detection:

- **Flutter:** Google's UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
- **Dart:** The programming language used for developing Flutter applications, providing a concise and expressive syntax.

The backend integration with Django provides the necessary AI capabilities for detecting edited regions on facial images. [Check here](https://github.com/anh-nt24/PhotoshoppedFaceDetection_API).

## Screenshots

Figma design: [here](https://www.figma.com/design/pT6wvj73j4eX4mIYZMSHfE/PurePixel-App?node-id=0-1&t=1vt1lqI0W7Inqb4e-0)

<p align="center">
  <img src="https://github.com/anh-nt24/PhotoshoppedFaceDetection_App/assets/106876168/cbdf1da7-3833-4c18-a7ca-7105c6de34a4" width="250" />
  <img src="https://github.com/anh-nt24/PhotoshoppedFaceDetection_App/assets/106876168/99903b8b-c6b1-4da3-9e2d-419046830155" width="250" />
  <img src="https://github.com/anh-nt24/PhotoshoppedFaceDetection_App/assets/106876168/8f4360a5-49b8-45c4-909e-5c43f7bb9a3e" width="250" />
</p>


## Getting Started

Follow these instructions to set up and run the PurePixel app on your local machine.

### Prerequisites

Ensure you have the following installed on your system:

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- [Android Studio](https://developer.android.com/studio) (for Android device emulation) or using your physical device


### Installation

1. **Clone the Repositories:**

  Firstly, clone the front-end repository:
   ```bash
   git clone https://github.com/anh-nt24/PhotoshoppedFaceDetection_App
   ```

  Secondly, clone the back-end repository:
  ```bash
   git clone https://github.com/anh-nt24/PhotoshoppedFaceDetection_API
   ```

2. **Start the server**:

    Reference instructions on the [README](https://github.com/anh-nt24/PhotoshoppedFaceDetection_API) file from the repository


2. **Navigate to the Project Directory:**

    ```sh
    cd PhotoshoppedFaceDetection_App
    ```

3. **Install Dependencies:**

    ```sh
    flutter pub get
    ```

4. **Run app:**
  
  Use of the command line

    ```sh
    flutter run
    ```

  or run from IDE/code editor


## Usage

- Open the PurePixel app on your device.
- Upload an image to detect edited regions on facial images.
- View the heatmap overlaid on the detected regions.


