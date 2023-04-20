 current bugs

registering an account leads to errors
- eiter because capital letters are not supported in usernames
- or certain inputValidators in the frontend for the password are not handled well in processing in the backend, before hashed.

# Chatbot app - HeroChat

## Introduction

HeroChat is an iOS chatbot app developed using SwiftUI that allows users to interact with famous personas, both real and fictional. The app features a sleek and easy-to-use interface, complete with an authentication system, integration with the OpenAI backend, and a selection of personas to chat with.

## Comprehensive list of the main features

### Authentication system

The app has a built-in authentication system that allows users to sign up and log in to their accounts. The authentication system ensures that user data is secure and that chat history is saved only for the authenticated user.

### Chat view

Once logged in, users can select a persona and start a chat session with them. The chat view has a clean and modern design, featuring text bubbles for both the user and the selected persona. Users can send messages and receive responses from the persona in real-time.

### Integration with OpenAI backend

The app is integrated with a node.js backend that connects to the OpenAI api, utilizing the text-davinci-003 model to generate human-like responses based on user input. This allows users to have engaging conversations with the selected personas.

### Selection of famous personas (real and fictional)

HeroChat offers a list of famous personas, both real and fictional, for users to chat with. Users can choose from a variety of personas, ranging from historical figures to popular characters from movies and books.

## Getting Started


### Prerequisites (e.g., software, API keys, etc.)

Xcode 13 or later
Swift 5.5 or later
iOS 15 or later

### Installation (e.g., cloning the repository, installing dependencies)

The entire system requires three repositories to work. 
Two of those need to run locally, one is already deployed.

Clone the following repositories:

chatbot_frontend - iOS App
```bash
git clone https://github.com/CharlieBravoCode/chatbot_frontend
```

chatbot_backend_authlogin - node.js app
```bash
https://github.com/CharlieBravoCode/chatbot_backend_authlogin
```

(optional) chatbot_backend_chat - node.js app
```bash
https://github.com/CharlieBravoCode/chatbot_backend_chat
```


### Configuration (e.g., setting up environment variables, API keys)

No configuration needed.
### Running the app (e.g., launching the app on a local server or emulator)

#### Step 1. chatbot_backend_authlogin

Run the chatbot_backend_authlogin

```bash
npm install
tsc
node index.js 
```

#### Step 2. chatbot_backend_authlogin

Run the chatbot_frontend

Open the HeroChat.xcodeproj file in Xcode.
Choose a simulator
Press the Play button or use the shortcut Cmd + R to build and run the app.

## A guide on how to use the app, including:

### Signing up and logging in

When the app launches, you will be presented with the authentication view.
If you're a new user, tap on "Sign Up" to create an account. Enter your email, username, and password, and tap "Sign Up" again to complete the registration.
If you already have an account, tap on "Log In" and enter your email and password. Then, tap "Log In" again to access the app.

![Login View](/Assets/readme/LoginView.png)

### Choosing a persona to chat with

After logging in, you'll be presented with the home view, displaying a list of available personas.
Tap on a persona to start a chat session with them.
### Starting a chat session

In the chat view, type your message in the text field at the bottom of the screen.
Tap the send button (arrow up icon) to send your message.
The selected persona will respond in real-time, and you can continue the conversation as desired.
### Screenshots

TODO: Add screenshots of the app showcasing the main features.
## Code Documentation

### Directory structure

- HeroChat/ - Main app directory
  - Authentication/ - Contains authentication-related views and view models
  - Chat/ - Contains chat
  - Settings/ - Contains settings-related views and view models
  - Services/ - Contains service classes for interacting with the API and backend
  - Components/ - Contains reusable components used throughout the app
  - Models/ - Contains data models and structures
  - App.swift - Contains the main app entry point
  - ContentView.swift - Contains the main content view

### Main components and their functions

- AuthenticationView: The view responsible for handling user authentication, including sign up and log in.
- HomeView: The view displaying the list of available personas for users to chat with.
- ChatView: The view responsible for displaying the chat session between the user and the selected persona.
- SettingsView: The view responsible for displaying user settings and enabling the user to log out.
- SubmitButton: A reusable button component used throughout the app.

### Important classes and methods

- AuthenticationService: Handles the communication with the backend for user authentication (sign up and log in).
- ChatService: Handles the communication with the OpenAI backend to generate responses based on user input.
- SettingsService: Handles the communication with the backend for fetching and updating user data.
- UserData: A class that stores the user's authentication token and other relevant information.
- ViewModel: An observable object that updates the view when something is changed.

### How the app interacts with the OpenAI backend

- The ChatService class is responsible for interacting with the node.js backend.
- When a user sends a message in the chat view, the message is sent to the ChatService class.
- The ChatService class makes an API call to the OpenAI backend using the GPT-4 API with the user's input.
- The node.js backend processes the user input and generates a response based on the selected persona's characteristics.
- The response from the node.js backend is returned to the ChatService class, which then updates the chat view with the new message from the persona.
