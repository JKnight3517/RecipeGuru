# RecipeGuru

[![Swift](https://img.shields.io/badge/Swift-5.5_5.6_5.7_5.8-orange?style=flat-square)](https://img.shields.io/badge/Swift-5.5_5.6_5.7_5.8-Orange?style=flat-square)

Recipe Guru is a simple SwiftUI applications that allows users to look up information about recipes using the [Spoonacular APi](https://spoonacular.com/food-api/docs#Get-Recipe-Information).

## Install Instructions
- Update to at least Xcode 14.2 to avoid any build errors
- Replace the API Key in the queryItems var of the Endpoint.swift file with your own Spoonacular API, otherwise the limit may be reached and new requests won't succeed until the next day

## Features
- Ability to search for different types of recipe by keyword
- Offline Local Storage of recipe details and title photo.
- Ability to mark a recipe as Favorite which will then store that recipe locally
![Screenshot 2023-09-01 at 1 59 22 AM](https://github.com/JKnight3517/RecipeGuru/assets/24241139/1a6c7133-69b8-4917-91d1-01855a9cbd04)
![Screenshot 2023-09-01 at 2 01 10 AM](https://github.com/JKnight3517/RecipeGuru/assets/24241139/a0a98a33-e129-4998-aab1-b78045b2bc38)

## Architecture
- This app largely follows the common MVVM architecture so each view will have a view model. The view reacts to changes in the view model and update accordingly, while the viewModel handles initiating and receving responses from API calls as well as fetching and storing data to Core Data.
- Right now the Offline storage solution is Core Data which works well for handling the recipe details

- 
## TODO 
- Remaining faithful to the ~ 4-5 hours alotted for this project, there are some areas that need to be updated
  1. Implement API Tests
  2. Add better Error Handling
  3. Implemnt UI Tests
  4. Fix locally stored image loading on list view
  5. Code Clean up and review
  6. Add an Icon
