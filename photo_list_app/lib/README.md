# Photo List App

A Flutter mobile app to browse and search some photos.
The app demonstrates state management with Cubit, API fetching, local caching with Hive, and clean architecture.

## Features

- Display a list of photos in chronological order
- Search photos (keywords that matches - location, description, createdBy, takenAt)
- Photo detail view: location, description, creator, date
- Cached images
- Pull to refresh available on PhotoListScreen

## Project Structure

lib/
├─ data/ # API, Hive models, repository implementation
├─ business/ # Cubit (state management), services
├─ presentation/ # Screens and UI widgets

## PhotoListScreen

- This is the homepage of the application.
- Which you can see a search bar and a list of photos with their corresponding locations.
- In the search bar, users can enter keywords to filter the photos, the keywords will match against the location, description, createdBy, and takenAt of the photos.
- Users can click the photo to navigate to the detail screen of the specific photo.
- Users can pull down the list to refresh the photos to see if API returns any new photos

## PhotoDetailScreen

- This is the screen for display all related information of a particular photo.
- This page shows the photo itself, with information such as location, the creator, the time of it taken and the description of the photo.
- User can go back to the PhotoListScreen on the top left hand back arrow button.

## State Management

- This application uses Cubit as the state managemnet tool
- PhotoCubit manages the PhotoState and other business logic such as load photos, search photos.
- PhotoState contains:
  - status (isLoading, loaded, initial)
  - photos (full list of photos)
  - filteredPhotos (filtered list of photos)
  - errorMessage

## Caching With Hive

- Hive is used to store previously fetched photos locally.
- On app launch:
  - Load cached photos immediately for fast display.
  - Fetch fresh photos from API in background and update state.
- Each photo is stored with its unique ID.
- Cached images are handled using cached_network_image for smooth scrolling.

## Testing

- Unit Test for PhotoService
- Widget Test for PhotoListScreen (Empty List, display Photos)
- Mocktail is used to mock services in tests.
