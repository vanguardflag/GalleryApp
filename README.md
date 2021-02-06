# flickr Gallery App
This project aims to consume data from [flickr](https://www.flickr.com/services/api/) in order to present a photo list screen with search functionality. also user can open the image 

# Requirements
  iOS 14.2
# Structure

| Components           | Main Responsability | 
| -------------        |:-------------------:| 
| PhotoGalleryBuilder  | Instantiates dependencies and  photo collection viewcontroller  | 
| PhotoURLService  | call the flickr.photos.getSizes for getting the url of different size for an image          | 
| PhotosService       | call the flickr.photos.search for getting the photo list base on tag search             | 
| PhotoPreviewerViewController |  for previewing the image in large size |


# External Dependencies 
GalleryApp Project has afew external dependecies, although a framework like [RxSwift](https://github.com/ReactiveX/RxSwift) could be a good fit for a list search feature and also pass the data between interacter and Services. RxSwift is a heavy framework, and for this reason, I decided to leave it outside of this simple project.

# Tests ✅
This project is covered with some Unit Tests in Services and Interactor. Due to my lack of experience and time, I wasn't able to expand them to the UI layer. Probably is something I should study and improve for the next time.

# Thank You
Regardless of the outcome of this challenge I would like to thank you the opportunity. It's always a pleasure work in fun stuff😃

# Author
Jalal Najafi - najafi.jalal.cse@gmail.com
