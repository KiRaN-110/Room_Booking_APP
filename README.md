# Institute Classroom Booking App

The Institute Classroom Booking App is a mobile application built using Flutter and Google Firebase. It provides a convenient way for professors and clubs to book classrooms within your institute, in addition to regular class schedules. The app offers separate interfaces for administrators and users, allowing efficient management of classroom bookings.

## Features

- **Admin Interface:** The admin interface provides administrators with a comprehensive view of all current classroom booking requests. The following information is displayed for each request:

  - Sender Name
  - Time Period
  - Classroom Name
  - Date of Demand
  - Email ID

  Administrators have the authority to accept or reject each request.

- **User Interface:** The user interface allows users to check the availability of classrooms and submit booking requests. The following features are available to users:

  - Classroom Availability: Users can view the availability status of each classroom for their desired booking period.
  - Booking Request: Users can submit a booking request for a specific classroom if it is available.
  - Request History: Users can review all their past and current booking requests along with the status (accepted, rejected, or pending).

## Technologies Used

- Flutter: A cross-platform UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
- Google Firebase: A comprehensive development platform that provides backend services, hosting, real-time databases, authentication, and more.

## Installation

1. Clone the repository from GitHub:

   ```bash
   git clone https://github.com/your-username/your-repo.git

2. Set up Flutter on your development environment. For detailed instructions, refer to the Flutter documentation.

3. Configure the Firebase project:

    - Create a new project on the Firebase Console.
    - Enable the necessary Firebase services (e.g., Firebase Authentication, Firebase Realtime Database).
    - Download the google-services.json file and place it in the appropriate location within your project.

4. Install the required dependencies by running the following command in the project directory:
  
  ```bash
  flutter pub get
  ```
  
5. Run the app on an emulator or connected device:

  ```bash
  flutter run
  ```
  
## Contributing

We welcome contributions to enhance the Institute Classroom Booking App. To contribute, please follow these steps:

1. Fork the repository on GitHub.

2. Create a new branch for your feature/fix:
```bash
git checkout -b feature/your-feature
```

3. Make your modifications and commit them with descriptive messages:
```bash
git commit -am 'Add your feature'
```

4. Push your branch to your forked repository:
```bash
git push origin feature/your-feature
```

5. Submit a pull request detailing your changes.
