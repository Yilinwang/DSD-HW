(function() {
	// Obtain a reference to the canvas element using its id.
	var htmlCanvas = document.getElementById('c'),

	// Obtain a graphics cxt on the  canvas element for drawing.
	cxt = htmlCanvas.getContext('2d');

	// Start listening to resize events and draw canvas.
	initialize();

	function initialize() {
		// Register an event listener to call the resizeCanvas() function each time 
		// the window is resized.
		window.addEventListener('resize', resizeCanvas, false);

		// Draw canvas for the first time.
		resizeCanvas();
	}

	// Display custom canvas.
	function redraw() {
		FF(1, 150, 150, 150, 150);
		FF(2, 150, 450, 150, 150);
		FF(3, 150, 750, 150, 150);
		FF(4, 550, 150, 150, 150);
		NOT(550, 450);
		OR(550, 600);
		AND(550, 750);
	}

	// Runs each time the DOM window resize event fires.
	// Resets the canvas dimensions to match window, then draws the canvas accordingly.
	function resizeCanvas() {
		htmlCanvas.width = window.innerWidth;
		htmlCanvas.height = window.innerHeight;
		redraw();
	}

	// Gates and FFs
	function NOT(x, y){
		var width = 25;
		var height = 25;
		cxt.moveTo(x, y);
		cxt.lineTo(x+1.5*width, y+height);
		cxt.moveTo(x+1.5*width, y+height);
		cxt.lineTo(x, y+2*height);
		cxt.moveTo(x, y+2*height);
		cxt.lineTo(x, y);
		cxt.moveTo(x+1.5*width+10, y+height);
		cxt.arc(x+1.5*width+5,y+height,5,0,2*Math.PI);
		cxt.moveTo(x+1.5*width+10, y+height);
		cxt.lineTo(x+1.5*width+10+width, y+height);
		cxt.moveTo(x, y+height);
		cxt.lineTo(x-width, y+height);
		cxt.stroke();
	}

	function AND(x, y){
		var width = 25;
		var height = 25;
		cxt.moveTo(x, y);
		cxt.lineTo(x+width, y);
		cxt.moveTo(x+width, y);
		cxt.arc(x+width, y+height, height,1.5*Math.PI,0.5*Math.PI);
		cxt.moveTo(x+width, y+2*height);
		cxt.lineTo(x, y+2*height);
		cxt.moveTo(x, y+2*height);
		cxt.lineTo(x, y);
		cxt.moveTo(x, y+0.5*height);
		cxt.lineTo(x-width, y+0.5*height);
		cxt.moveTo(x, y+1.5*height);
		cxt.lineTo(x-width, y+1.5*height);
		cxt.moveTo(x+width+height, y+height);
		cxt.lineTo(x+width+height+width, y+height);
		cxt.stroke();
	}

	function OR(x, y){
		var width = 25;
		var height = 25;
		cxt.moveTo(x, y);
		cxt.lineTo(x+width, y);
		cxt.moveTo(x+width, y);
		cxt.arc(x+width, y+height, height,1.5*Math.PI,0.5*Math.PI);
		cxt.moveTo(x+width, y+2*height);
		cxt.lineTo(x, y+2*height);
		cxt.moveTo(x, y);
		cxt.quadraticCurveTo(x+width, y+height, x, y+2*height);
		cxt.moveTo(x+width+height, y+height);
		cxt.lineTo(x+width+height+width, y+height);
		cxt.moveTo(x+0.4*width, y+0.6*height);
		cxt.lineTo(x-width, y+0.6*height);
		cxt.moveTo(x+0.4*width, y+1.4*height);
		cxt.lineTo(x-width, y+1.4*height);
		cxt.stroke();
	}

	function FF(type, x, y, width, height){
		var margin = 10;
		cxt.font = "24px Consola";
		cxt.rect(x, y, width, height);
		if(type == 1)
			cxt.fillText('D', x+margin, y+0.25*height);
		else if(type == 2)
			cxt.fillText('T', x+margin, y+0.25*height);
		else if(type == 3)
			cxt.fillText('J', x+margin, y+0.25*height);
		else if(type == 4)
			cxt.fillText('S', x+margin, y+0.25*height);

		cxt.fillText('Q', x+width-3*margin, y+0.25*height);
		cxt.fillText('FF', x+0.425*width, y+0.55*height);
		cxt.fillText('—', x+width-3.25*margin, y+0.75*height);
		cxt.fillText('Q', x+width-3*margin, y+0.85*height);
		cxt.moveTo(x, y+0.7*height);
		cxt.lineTo(x+0.2*width, y+0.8*height);
		cxt.moveTo(x+0.2*width, y+0.8*height);
		cxt.lineTo(x, y+0.9*height);
		cxt.moveTo(x, y+0.2*height);
		cxt.lineTo(x-0.4*width, y+0.2*height);
		cxt.moveTo(x, y+0.8*height);
		cxt.lineTo(x-0.4*width, y+0.8*height);
		cxt.moveTo(x+width, y+0.2*height);
		cxt.lineTo(x+width+0.4*width, y+0.2*height);
		cxt.moveTo(x+width, y+0.8*height);
		cxt.lineTo(x+width+0.4*width, y+0.8*height);
		cxt.stroke();
	}

})();
