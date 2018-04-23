# ProductViewer

### Description
A simple IOS app that retrieves a list of products and display them in a table view and detail view.


### API
https://mobile-tha-server.appspot.com
 
### Product list
It contains a list of all products returned by an HTTP GET request from the API.
It supports lazy loading of images while actively loading products metadata page by page since 1) metadata is much smaller than images and downloading them won't cause any perceivable delay, and 2) metadata can be used to provide usable user experience prior to image downloads.

+ Lazy loading of images: when a user scrolls to the bottom of the current list, we donload the images for next page.

+ UI: try to have the similar look and feel as the Walmart app. Each product cell contains image, name, price, rating, rating count, and in stock status. A simple rating control is implemented to display rating in stars, with whole star value only.\\

+ Corner cases: we filter out the non human readable characters in the item names.

### Product details
It displays the detailed information of the selected product item. 

+ Swipe support: it supports swipe gestures, left and right, to display the next and previous product item respectively.

+ Lazy loading of images: when a user swipe to an item, we download the image of the next item so that when the use swipe left again, the image is already there and the detailed view is complete.

+ UI: it displays the long description following the HTML format.

+ Corner cases: some items don't have descriptions (long or short). Display a default descripion in this case. 
