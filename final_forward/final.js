(function() {
	// Obtain a reference to the canvas element
	// using its id.
	var htmlCanvas = document.getElementById('c'),

	// Obtain a graphics context on the
	// canvas element for drawing.
	context = htmlCanvas.getContext('2d');

	// Start listening to resize events and
	// draw canvas.
	initialize();

	function initialize() {
		// Register an event listener to
		// call the resizeCanvas() function each time 
		// the window is resized.
		window.addEventListener('resize', resizeCanvas, false);

		// Draw canvas border for the first time.
		resizeCanvas();
	}

	// Display custom canvas.
	function redraw() {
		//FF(1, 150, 150, 150, 150);
		OR(150, 150);
	}

	// Runs each time the DOM window resize event fires.
	// Resets the canvas dimensions to match window,
	// then draws the new borders accordingly.
	function resizeCanvas() {
		htmlCanvas.width = window.innerWidth;
		htmlCanvas.height = window.innerHeight;
		redraw();
	}

	function NOT(x, y){
		var width = 50;
		var height = 25;
		context.beginPath();
		context.moveTo(x-width, y+height);
		context.lineTo(x, y+height);
		context.moveTo(x, y);
		context.lineTo(x+width, y+height);
		context.moveTo(x+width, y+height);
		context.lineTo(x, y+width);
		context.moveTo(x, y+width);
		context.lineTo(x, y);
		context.moveTo(x+width+10, y+height);
		context.arc(x+width+5,y+height,5,0,2*Math.PI);
		context.moveTo(x+width+10, y+height);
		context.lineTo(x+width+10+width, y+height);
		context.stroke();
	}

	function AND(x, y){
		var width = 25;
		var height = 25;
		context.beginPath();
		context.moveTo(x, y);
		context.lineTo(x+width, y);
		context.moveTo(x+width, y);
		context.arc(x+width, y+height, height,1.5*Math.PI,0.5*Math.PI);
		context.moveTo(x+width, y+2*height);
		context.lineTo(x, y+2*height);
		context.moveTo(x, y+2*height);
		context.lineTo(x, y);
		context.moveTo(x, y+0.5*height);
		context.lineTo(x-width, y+0.5*height);
		context.moveTo(x, y+1.5*height);
		context.lineTo(x-width, y+1.5*height);
		context.stroke();
	}

	function OR(x, y){
		var width = 25;
		var height = 25;
		context.beginPath();
		context.moveTo(x, y);
		context.lineTo(x+width, y);
		context.moveTo(x+width, y);
		context.arc(x+width, y+height, height,1.5*Math.PI,0.5*Math.PI);
		context.moveTo(x+width, y+2*height);
		context.lineTo(x, y+2*height);
		context.moveTo(x, y);
		context.quadraticCurveTo(x+width, y+height, x, y+2*height);
		context.moveTo(x+width+height, y+height);
		context.lineTo(x+width+height+width, y+height);
		context.moveTo(x+0.4*width, y+0.6*height);
		context.lineTo(x-width, y+0.6*height);
		context.moveTo(x+0.4*width, y+1.4*height);
		context.lineTo(x-width, y+1.4*height);
		context.stroke();
	}

	function FF(type, x, y, width, height){
		var margin = 10;
		context.font = "20px Consola";
		context.rect(x, y, width, height);
		if(type == 1)
			context.fillText('D', x+margin, y+2.5*margin);
		else if(type == 2)
			context.fillText('T', x+margin, y+2.5*margin);
		else if(type == 3)
			context.fillText('J', x+margin, y+2.5*margin);
		else if(type == 4)
			context.fillText('S', x+margin, y+2.5*margin);

		context.fillText('Q', x+width-2.5*margin, y+2.5*margin);
		context.fillText('FF', x+0.425*width, y+0.55*height);
		context.fillText('—', x+width-2.5*margin, y+height-3*margin);
		context.fillText('D', x+width-2.5*margin, y+height-1.5*margin);
		context.stroke();
	}

})();
