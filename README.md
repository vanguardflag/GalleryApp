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

# Author
Jalal Najafi - najafi.jalal.cse@gmail.com
