// Turn cards memory game
// By Ulf R. Pedersen (ulf@urp.dk)
//   September 2015

var img = new Array();	// Array of image objects
var aud = new Array();	// Array of audio objects
var other_img = null;
var turn_wait_time = 1500;	// Wait time for turnig cards
var num_sounds=6;


// Run when page is loaded
function initialize(input_rows,input_cols) {
	// Setup canvas
	canvas = document.getElementById("memory_game");
	width=canvas.width;
	height=canvas.height;
	ctx = canvas.getContext("2d");
	
	// Number of rows and columns
	rows=input_cols
	cols=input_rows

	// Add event listener for mouse clicks
	canvas.addEventListener("mousedown", mouse_click, false);
	
	// Set image links, and set default values
	img_backside = document.getElementById("img_backside");
	for ( var x=0 ; x<rows ; x++ ) {
		for ( var y=0 ; y<cols ; y++ ) {
			i = index(x,y);
			img[i] = document.getElementById("img" + i);
			if(img[i] == null ) { 
				console.log('Error loading image number ' + i + ' with id img'  + i );	
			} else { 
				console.log('Load image ' + i + ': ' + img[i].src );	
			} 
			img[i].is_shown=false;	// True if the player have turned this card
			img[i].is_found=false;	// True if player have identified this cards
			img[i].identity=Math.floor(i/2);	// Two matching cards have same identity
		}
	}

	// Shuffle cards
	for (var c=1;c<rows*cols*2;c++){
		swop_cards(Math.floor(Math.random()*rows*cols),Math.floor(Math.random()*rows*cols));	
	}

	// Add sounds for turning cards
	for ( var i=0;i<num_sounds;i++ ) {
		//aud[i] = new Audio("audio/aud" + i);
		aud[i] = document.getElementById("aud" + i);
		console.log('Load sound ' + i + ': ' + aud[i].src );	
	}

	
	// Draw back sides of cards
	hide_all_cards();
	
	console.log('Done with initializing');
}

// Convert x and y coordinate of card to image index
function index(x,y){
	return  y + x*cols;
}

// Run when mouse is clicked on canvas
function mouse_click(e) {
	
	// Coordinates of clicked card
	var rect = canvas.getBoundingClientRect() ;
	var x=Math.floor( (e.x-rect.left)/width*rows ) ;
	var y=Math.floor( (e.y-rect.top)/height*cols ) ;
		
	var i = index(x,y);
	console.log('Mouse clicked: e.x=' + e.x + ' e.y=' + e.y + ' x=' + x + ' y=' +y +' img[i].is_shown= ' + img[i].is_shown);
	
	if(num_shown_cards()>1) {  // Hide cards if two cards are shown
		hide_all_cards();
	} else {
		if(!img[i].is_shown){

			ctx.drawImage(img[i], x*width/rows, y*height/cols, width/rows, height/cols);
			img[i].is_shown = true;
			if(num_shown_cards()==1){  // This is the first turned card -- save identity
				other_img = img[i]
			} else {	// This is the second found card ... see if they match
				if(other_img.identity == img[i].identity) {
					console.log('Congrats, you have found a match!');
					other_img.is_found=true;
					img[i].is_found=true;
				}
				setTimeout("hide_all_cards()",turn_wait_time);
			}
			// Play (random) a turned card audio
			aud[ Math.floor( Math.random()*aud.length) ].play();
		}
	}

	if( game_over() ){
		window.alert("All cards have been found. Game over.");
		console.log('Game over!');
	} else {
		console.log('Game on ...');
	}
	//print_state() ;
}


// Draw backside of all cards
function hide_all_cards(){
	console.log('hide_all_cards() ' );	
	for (var x=0;x<rows;x++){
		for(var y=0;y<cols;y++){
			var i = index(x,y);
			ctx.drawImage(img_backside, x*width/rows, y*height/cols,width/rows, height/cols);
			img[i].is_shown=false;
			
			// "Special" drawing of found cards
			if(img[i].is_found) {
				ctx.drawImage(img[i], x*width/rows, y*height/cols,width/rows, height/cols);
			}
		}
	}
}

// Swop to cards
function swop_cards(i,j) {
	var tmp = img[i];
	img[i]=img[j];
	img[j]=tmp;
}

// Printing function for debugging
/*function print_state() {
	for (var x=0;x<rows;x++){
		for(var y=0;y<cols;y++){
			i = index(x,y);
			console.log('('+x+','+y+')='+img[i].is_shown);
		}
	}
}*/



// Return number of turned cards (not including found cards)
function num_shown_cards() {
	var counter=0;
	for ( var x=0 ; x<rows ; x++ ) {
		for ( var y=0 ; y<cols ; y++ ) {
			if(img[index(x,y)].is_shown==true){
				counter++;
			}
		}
	}
	console.log('num_shown_cards() = ' + counter );
	return counter;
}



// return true if all cards are found
function game_over() {
	var counter=0;
	for ( var i=0 ; i<rows*cols; i++ ) {
		if(img[i].is_found){
			counter++;
		}
	}
	console.log('Cards found: ' + counter );
	if(counter==rows*cols){
		return true;		
	} else {
		return false;
	}
}


