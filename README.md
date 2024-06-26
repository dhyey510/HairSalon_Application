# Hair Salon Application

Welcome to the Hair Salon Application! This Flutter project empowers users to discover nearby hair salons, explore salon details, book appointments, manage their profile, view appointment history, receive notifications, and try out different hairstyles and hair colors using machine learning models.

## Features

- **Find Nearby Salons**: Users can search for nearby hair salons using the Yelp API.
- **Salon Details**: View detailed information about specific salons, including ratings, reviews, and services offered.
- **Appointment Booking**: Easily book appointments with preferred salons.
- **Profile Management**: Users can edit their profiles and view/update their information.
- **Appointment History**: View past appointment history for reference.
- **Notifications**: Receive notifications for appointment reminders and other updates.
- **Virtual Hairstyle Try-On**: Utilize machine learning models hosted on the Replicate platform to try out different hairstyles and hair colors by uploading an image and clicking the predict button.

## Technologies Used

- **[Flutter](https://flutter.dev/)**: Used for building the mobile application.
- **[Dart](https://dart.dev/)**: Programming language used for developing the Flutter app.
- **[Yelp API](https://www.yelp.com/developers)**: Integrated for retrieving salon data.
- **[Replicate Platform](https://replicate.ai/)**: Utilized for hosting and integrating machine learning model (I used `hair_clip` model).
- **[Firebase](https://firebase.google.com/)**: Used for storing and retrieving users data as well as for authentication.

## Installation

To run the project, follow these steps:

1. Clone the repository:
`git clone https://github.com/dhyey510/HairSalon_Application.git`

2. Integrate Firebase with this project

3. Create an `.env` file with Yelp API and Replicate API and placed this file inside `lib` folder.

4. Run the Flutter project:
`flutter run`

## Screenshots/GIFs

<div align="center">
<img src="screenshots/HomeScreen.png" alt="Description of image" width="300" style="margin-right: 40px">        <img src="screenshots/SalonDetail.png" alt="Description of image" width="300">
</div>
 
<div align="center">
<img src="screenshots/Confirmation.png" alt="Description of image" width="300" style="margin-right: 40px">     <img src="screenshots/History.png" alt="Description of image" width="300">      <img src="screenshots/StyleScreen.png" alt="Description of image" width="300" style="margin-right: 40px">
</div>


## License

This project is licensed under the [MIT License](LICENSE).

## Acknowledgements

- Thanks to the [Yelp API](https://www.yelp.com/developers) for providing salon data.
- Special thanks to [Replicate](https://replicate.ai/) for hosting machine learning models.

## Support

For any inquiries or support, please contact [dhyey870@gmail.com](mailto:dhyey870@gmail.com).
