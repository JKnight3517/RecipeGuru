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

<img width="350" alt="Screenshot 2023-09-05 at 2 03 32 PM" src="https://github.com/JKnight3517/RecipeGuru/assets/24241139/06a42596-7229-41a0-8fda-800edf775a16">

<img width="350" alt="Screenshot 2023-09-05 at 2 04 25 PM" src="https://github.com/JKnight3517/RecipeGuru/assets/24241139/d59cb66f-216a-49ed-8806-1244ea010ba3">



## Architecture
- This app largely follows the common MVVM architecture so each view will have a view model. The view reacts to changes in the view model and update accordingly, while the viewModel handles initiating and receving responses from API calls as well as fetching and storing data to Core Data.
- Right now the Offline storage solution is Core Data which works well for handling the recipe details

## TODO 
- Remaining faithful to the ~ 4-5 hours alotted for this project, there are some areas that need to be updated
  1. Implement API Tests
  2. Add better Error Handling
  3. Implement UI Tests
