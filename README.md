# BeerShopApp
This application will fetch all the beer's list and will list it out for the user. Added search functionality with ascending order sorting and also provided with add to cart functionality. 

Hi!! Please find the list of items I’ve covered with this application.

I’ve attached the sample GIF file that shows demo from simulator

<a href="https://imgflip.com/gif/36ots8"><img src="https://i.imgflip.com/36ots8.gif" title="made at imgflip.com"/></a>

<a href="https://imgflip.com/gif/36otwj"><img src="https://i.imgflip.com/36otwj.gif" title="made at imgflip.com"/></a>

<a href="https://imgflip.com/gif/36otyi"><img src="https://i.imgflip.com/36otyi.gif" title="made at imgflip.com"/></a>

<a href="https://imgflip.com/gif/36otzn"><img src="https://i.imgflip.com/36otzn.gif" title="made at imgflip.com"/></a>

<a href="https://imgflip.com/gif/36ou26"><img src="https://i.imgflip.com/36ou26.gif" title="made at imgflip.com"/></a>

Here is the technical stack I’ve used.
Design Pattern: MVVM
View Controllers: 2

→ View Controller -- this is the main VC where it has the capability to show the beerlist and also it has search bar at the top. I’ve also added cart functionality on the navigation bar.

NOTE: I’ve used default search bar that comes with Navigation bar since most users would be familiar to use this. So initially if you didn’t see the search bar, please do pull from the UI and you will be able to see it. 

→ PlaceOrderViewController -- This view controller will be presented when the user taps on the cart icon from the home page. From this, the user can place the order. As of now, I’ve reused the same collectionview cell whatever I’ve used in previous controller and hidden the choose button. 

Functionalities covered:
Added search functionality with beer name & also sorted with ascending order as per requirements.
Handled no network connectivity scenario.
Covered all the scenarios for user picking up the beer from the beer list either through normal scroll or from the search results. 
Maintained session of user picked items & add to cart items
Handled real time add to cart items as when user deselects an item, you can observe from the screen that the icon badge number will be getting reduced
Added elegant UI with rich UI’s covered with spinners and alert views
Handled memory management in all the closures. 

Features not covered: 
I thought of creating separate view to sort the beers. But time doesn't permitted me. So that is pending still.

Known Issue: 
Whenever the user searches an item and give search, the text on the search bar will become empty. But this will not be a showstopper and will never break any other functionality.

Write me if you have any questions.  gashok0705@gmail.com


Thank you & Happy coding :) 

