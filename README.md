# course_project
Project Part 3:
1-App Navigation and Structure:
Login and Logout Screens
●
●
A dedicated Login screen allows users to authenticate using their credentials.
Upon successful login, users are redirected to the main interface of the app.
●
A Logout function is provided to securely end the user session and return to the Login
screen.
Bottom Navigation Bar
●
●
●
A Bottom Navigation Bar is included to enable quick switching between major sections
of the app such as Home, Explore, Profile, etc.
Icons and labels help users easily understand each tab's function.
Navigation is persistent across all screens and ensures intuitive app flow.
Bottom App Bar
●
actions .
A Bottom App Bar is implemented to enhance usability and maintain access to key
●
The bar adapts contextually to the screen and content, improving interactivity.
2- Enhanced UI with Stacked Layouts:
We utilized Flutter’s Stack, Positioned, and Container widgets to create layered UI
elements, enabling multiple components to visually overlap in a meaningful way.
3- Improving Design with Interactive Lists and Layouts:
We utilized both ListView and GridView widgets across different screens to present structured
content effectively.
4- Firebase Database:
We have integrated flutter with Firebase and created multiple tables in the database:
Posts:
Approval:boolen,
createdAt:timeStamp,
Description:String,
Governate:String,
Image:String,
Location:String,
PlaceName:String,
PlaceType:String,
Rating:Integer,
UserId:String
Users:
id:String
email:String,
Password:String,
userName
Oman_Info:
Title:String
Description:String
Image
_
Url:String
5- Data Operations and Full Database Interaction:
In the database we have implemented all the CRUD operations:
1-Create: Allow the authenticated user to create new post.
2-Delete: Allow the authenticated user to delete his/her posts
3-Read:Read the posts from the database to show them for the users in the map page.
4-Update: allow the authenticated user to update his posts
7- Final Deployment to Mobile Devices:
We have Deployed our project in Android mobile phone in .apk .

Project Part 2:
The Mobile application screens:

Index Page: 
It gives the user an introduction about the application, it has multiple images about tourism places in oman, and a body that contain a text and a scrollable texts.

Add New Torisum place:

The page contains a form that has multiple types of input fields like one line input field , a multiple-line input field, a dropdown menu to select governorates for example, and input field to upload images.

Map Page: 
-In this page we render a list of places. Each place has image and information like the name and description.
-The Map Page also contains a filter dropdown, checkboxes, and radio buttons to filter the places.

Detailed Place Page:

The user is navigated to this page after clicking on one of the places’ posts, in this page we show detailed information about the place and it location also.

Login Page:

We have form to get the user credentials like email and password and validate the inputs. We use an alert to let the user know that he/she is logged in successfully. Also we user 

Sign up:

We have a form that has four input fields like email, password, name, and birth date.
We are using one line input filed and date picker to select the birth date.

About page:
A page that contains a centered text , describing the idea of the application.

Edit post page:
This page contains a form that fetches the data about the required post to edit the post information and then submit it.

At least 3 advanced Flutter widgets not covered in class used

1.AnimatedBuilder 
2.ClipPath
3.Image


A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.![Simulator Screenshot - iPhone 16 - 2025-04-08 at 19 10 53](https://github.com/user-attachments/assets/c44ef7d0-6d6a-48ac-97be-d10674b22e21)
![Simulator Screenshot - iPhone 16 - 2025-04-08 at 18 59 27](https://github.com/user-attachments/assets/ec6cf2c3-bcbc-4238-a789-d52a881e27e2)
![Simulator Screenshot - iPhone 16 - 2025-04-08 at 18 59 20](https://github.com/user-attachments/assets/7a31e01e-cedc-4e87-a180-0312032aa656)




