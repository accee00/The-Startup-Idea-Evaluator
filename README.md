# The Startup Idea Evaluator
**For more detail please check out this Notion doc- https://www.notion.so/The-Startup-Idea-Evaluator-259699fa5f3b8082a91cc22fe63c782e?source=copy_link **
## App Description
The Startup Idea Evaluator is a mobile application that allows users to submit their startup ideas, receive AI-generated feedback, vote on other users’ ideas, and see a leaderboard of top-rated ideas. 

## Tech Stack Used
- **Frontend:** Flutter  
- **Backend:** Supabase (PostgreSQL, Auth, Storage)  
- **State Management:** BLoC / Cubit  
- **Dependency Injection:** GetIt
- **Architecture:** MVC (Model View Controller)
 

## Features Implemented
- User authentication (Sign Up / Login)  
- Submit new startup ideas  
- AI-generated feedback and ratings on ideas  
- Vote and unvote on ideas  
- Top ideas leaderboard  
- Share ideas via clipboard  
- Responsive UI for mobile devices
- Dark/ Light modes  

## How to Run Locally
1. **Clone the repository:**  
```bash
to test get .env file from https://www.notion.so/Developer-reference-259699fa5f3b802c8f93cafc0f352e42
git clone https://github.com/accee00/The-Startup-Idea-Evaluator.git
cd  StartupIdeaEvaluator
flutter pub get
flutter run
