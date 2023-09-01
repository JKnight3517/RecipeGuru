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


## TODO 
- Remaining faithful to the ~ 4-5 hours alotted for this project, there are some areas that need to be updated
  1. Implement API Tests
  2. Add better Error Handling
  3. Implemnt UI Tests
  4. Fix locally stored image loading on list view
  5. Code Clean up and review
  6. Add an Icon
