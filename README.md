# Water Review App
By: Javier Carrillo

![App Image](https://github.com/javiiicz/Water-Review-App/blob/main/Water-Review-Img.png)


Demo Video: https://youtu.be/Wgc43QLooA8


Water Reviews is an IOS app built with the Swift programming language. The app lets users create reviews with sliders, an image, and a description. This review is then posted in the explore page for everyone with the app to see. Apart from SwiftUI, the project uses Firebase libraries such as FirebaseAuth, FirebaseStorage, and FirebaseDatastore for the server side functionality.

Upon opening the app, the mainView is called. In turn, this view calls the loginView. Effectiveley, the user is going to be brought to a screen with text fields for loging in. Additionally, one can switch to the registerView by pressing the button at the bottom of the screen. An account must be created in the registerView to use the app. I designed it this way because I envision the future of the app as a sort of social media.

To register, the user needs to input an email, a password, and confirm the password. In registerView, one can observe that upon clicking the "Sign Up" the code first checks for any empty fields, then if the email is not valid, then if the password and confirmation do not match, and finally creates the account. If any of the ckecks is true the account is not created and the user is met with a feedback message. If the user passes all the checks, the email, and password get passed to a Firebase function `Auth.auth().createUser()` which stores the user in the Firebase server.

To check the validity of the email, a function called isValidEmail is called with the email string. This function utilizes a standard Regular Expression to check if the string follows email format. This function does not check if the email is real or not.

Now that the credentials are created, the user can log in from the loginView with their email and password. The program checks if one of the inputs is empty or if the email is not valid. Then, the `Auth` function is called with the parameters and `handleSignInResult` is called if it does not return an error. In the casse there is an error, the feedback is shown to the user in the form of an alert. The `handleSignInResult` function stores the email of the signed in user in a global variable `MyVariables.email`. This variable is used to keep track of authors.

After logging in, the landingView is shown to the user. There is a welcome and the name of the user stored within the `MyVariables`. This view has 3 buttons: one to sign out, one to got o reviewView, and one to exploreView. The sign out button calls `.signOut()` method from `Auth` and returns the user to loginView. The other two buttons show their respective view.

The reviewView is the most sophisticated view in the project. Apart from a title and a back button, it presents the user with a title text field, a place to take a photo with the camera, multiple rating sliders, a description text field, and a submit button. Each element will be described now:

- The **Title and Description** text fields use a normal state variable to store their contents. An interesting aspect about them is that they have an `id` and an empty `onGesture` property. The text field is passed a UUID. When the user taps outside the text field a new UUID is created so the keyboard dissapears. This had to be done this way because there is no easy way to let the user hide the keyboard.

- The **Camera** was developed with Gemini as presenting the camera to the user is a little complex. A structure called `accessCameraView` following the `UiViewControllerRepresentable` protocol is created at the bottom this view. This truct creates a `UiImagePickerController` for camera access. This structure triggers the opening of the camera view, lets the use capture an image, dismisses and retrieves the captured image.

- The **Rating Sliders** are their own view `ratingSlider` that take an emoji, a string to display as their type, and biding variables to control the offset when the the user drags and present visual feedback. Each slider has two variables `initialDragOffset` and `dragOffset` that are used on a `.gesture` method to display movement of the sliders. The variables also serve as a vay to display the scores using the fraction of the full width that has been slided.

- The **Sumbit Button** takes all the variables (title, photo, each rating slider offset, and description) and passes it to a function called `submitReview`. Then, it resets all fields and variables. The `submitReview` function first acceses the Database using the Firebase Datasore library. A reference is created to a collection called "waterFountains". After the reference is created, the reference's id is stored in a variable `fountainID`. This id is used when creating the storage reference for the photo using Firebase Storage. Then, the photo data is stored in the reference. Finally, the database entry is created in the database. Each entry has id, name, flow (rating), flavor (rating), temperature (rating), location (rating), description, photoPath (which is the id.jpg), createdAt (timestamp), and createdBy (author).

Finally, exploreView is the final general view of the project, this shows the user all the fountains on the system. When the view appears, `getFountains` is called. This function acceses the database and creates a query `db.collection("waterFountains").order(by: "createdAt", descending: true)`. So, what is all the fountains in a list in descending order of when they were created. Then, back at the view, the `ForEach` creates a `fountainUnit` object with all the variables. This structure displays all information neatly and offers a way to download the piure from the server to the device by tapping the placeholder image. When the user taps the image, a reference to the desired photo is made and the function `downloadImage` gets the photo data. Additionally, an alert is used to display the decriptions of the water fountains.

An extra structure is the `MyShape` structure. This object utilizes the `Path` object to create a custom shape that is used in the rating slider.

Overall, this project was deeply useful to me because I got to apply multiple concepts I have learned in courses into a tangible product I am proud of. Additionally, I learned new skills like Swift, Xcode, Firebase, API's, Databases and Storage manipulation that I am sure I will use in my future life as a student and as a professional.
