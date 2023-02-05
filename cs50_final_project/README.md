# CS 50 Final Project: Brick Shooter!
### Video Demo: https://youtu.be/CYVCdTjXu78
### Description
Hello world! In this file, I'll make an in-depth explanation of my game, the various files I used, my stylistic choices and more. As the directory's title suggests, this project was made as a final project for the CS 50 course offered by Harvard on the edX platform. Without further ado, here's my analysis on my game: *Brick Shooter!*

#### General overview

*Brick Shooter!* is a 2D game that was made using the programming language Lua and its framework LÖVE. After watching the seminar on game development that was hosted on the CS50 course, I decided that I wanted to experiment with the program and make my first 2D game. Naturally, as it's a first game, it isn't as fully fledged as I would like it to be. But at least it wasn't for lack of trying. As recommended by the seminar, I followed a lengthy tutorial made by Sheepollution on the LÖVE framework. This was my primary resource for learning, and I sincerely recommend it to any beginner programmer that wants to give game development a shot. After finishing the tutorial, I had all the basic knowledge I needed to make my own game. 

As for the game itself, it's a single-player shooter. My inspiration came from my old childhood memory, where I played a very similar brick-destroyer-like game on a Blackberry. Infact, the objective here is to destroy all the bricks in the level. However, the player must also avoid their own bullets that bounce towards them. The player has 3 HP, and for each brick destroyed the player's icon gets slightly wider, and the bullets get slightly faster. The point, of course, is to make the game progressively harder as the player destroys more and more bricks. 

#### The visuals

![Screenshot_20230205_182204](https://user-images.githubusercontent.com/116917243/216834459-55d0de8e-9589-49b7-b485-d9960fdaace3.png)

There's not much to say about the game's look :P. The white rectangle in the middle is the player. The bricks vary in color, with the strongest (as in, the ones that take the most bullets to destroy) being the darkest. The bullet itself is a simple white circle. The level is confined by two white walls. The background (made on Paint by yours truly) serves to make the level visually more appealing. I used a font that I found online to display the player's score and health. Unfortunately, I wasn't able to find the authors of the fonts once again, but googling something along the lines of "vintage videogame fonts" one should be able to find a similar font. When the player is hit, everything on the screen acquires a reddish tint.

#### The mechanics

The player moves by pressing Right or Left arrow key. They shoot by pressing the Space Bar. Depending on how the player is moving when they shoot, the bullet will follow a certain trajectory: if the player is moving to the left, the bullet will go diagonally upwards towards the left, and the same goes when the player if the player is moving to the right. If the player stays still and shoot, the bullet will simply go upwards in a straight direction. The bullets themselves, once they hit an obstacle, bounce towards a certain direction. The player can only shoot up to 5 bullets in a given time, and the player can shoot more once the bullets go offscreen.

#### The SFX

The sound effects used were found online, and can be found when searching "vintage game free sound effects". For each type of bullet collsion, there's a unique sound that is associated with it.

#### The code

In this section, I want to explain more thoroughly the coding that was implemented. As you can imagine, the game is composed by several files. Other than the files containing SFX, images and the like, I thought it would have been more reasonable to split the code in multiple files. *main.lua* is responsible for putting all the different files into one cohesive unit. The code inside *classic.lua* was not written by me, and its usage was recommended in the aformentioned Sheepollution tutorial. It serves key purpose: it makes creating classes possible. Lua as a programming language does not provide its own type of classes, and thus to make the creation of classes possible (where every object has its own methods associated to it), I had to borrow these lines of code from the user "rxi" on GitHub. In *entity.lua* is defined a subclass of *object* class defined in *classic.lua*. *player.lua* defines all the player's characteristics. *brick.lua* and *ball.lua* serve the same purpose. *line.lua* defines the so-called wall object. Finally, *conf.lua* was created to then make the .exe file.

#### Final thoughts

It took me way longer than expected to create this small game. Even though it's limited in many ways, I'm still reasonably satisfied with the results and glad I was able to give a finished product. I want to thank CS50 for giving me the tools and resources to learn all of these things about programming! 

This was *Brick Shooter!*
