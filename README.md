# Voice.AI : A Conversational AI Assistant

Voice.AI is a Flutter-based mobile application designed to provide a seamless voice interaction experience. Utilizing the Speech-to-Text library for real-time voice recognition and OpenAI's API for natural language processing, the app allows users to interact with an intelligent assistant that can understand and respond to voice commands.

![Screenshot 2024-08-28 123034](https://github.com/user-attachments/assets/dd651af1-2ee4-4b95-aa2a-cd14f2ee78c4)


## Getting Started

Features:

- Real-Time Voice Recognition: Converts spoken words into text using the Speech-to-Text library, with the ability to handle both continuous and final results.
- OpenAI Integration: Connects with OpenAI's APIs to process user prompts, generate text-based responses, and create images using DALL-E based on the user's request.
- User Interface: Features a clean and intuitive design with a central voice assistant graphic and a list of app functionalities presented in a user-friendly manner.
- DALL-E Image Generation: Transforms user prompts into AI-generated art using the DALL-E model, making the assistant both functional and creative.

Technologies Used:

- Flutter: For cross-platform app development.
- Speech-to-Text: For converting speech into text.
- OpenAI API: For generating responses and images.
- Dart: The programming language used for development.
  
How It Works: Upon pressing the floating action button, the app starts listening to user commands. If the spoken input indicates a request for generating art or an image, the app utilizes OpenAI’s DALL-E API. For other queries, it employs the GPT-3.5-turbo model to provide text-based answers. The app's interface provides feedback and displays results directly on the screen.


