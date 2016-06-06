function makeCircuit(){
	$.get('/makeCircuit',function(data){
		var arg = data.split('\n');
		doCanvas(arg);
	});
}

function doCanvas(arg) {
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
		//#input, #FF, type of FF-> 1:D 2:T 3:JK 4:SR
		//J1=120 211 -> y2 * x' + y1 * x
		//K1=212 
		//J2=210 
		//K2=002 110
		var input_N = parseInt(arg[0]);
		var FF_N = parseInt(arg[1]);
		var FF_type = parseInt(arg[2]);
		var i;
		var web_h = $(document).height();
		var web_w = $(document).width();
		var FF_x = web_w-500;
		leftLine(parseInt(input_N)+parseInt(FF_N));
		rightLine(FF_N, input_N);
		//arg[1] >= 6 will overlap
		link(1, FF_N, input_N+FF_N, arg[6]);
		for(i = 1; i <= FF_N; i++){
			FF(FF_type, FF_x, (i/(parseInt(FF_N)+1))*web_h, 150, 150);
		/*
			if(FF_type <= 2){
				link(i, input_N+FF_N, arg[2+i]);
			}
			else if(FF_type >= 3){
				link(i, input_N+FF_N, arg[2*i+1]);
				link(i, input_N+FF_N, arg[2*i+2]);
			}
		*/
		}

		//NOT(550, 450);
		//OR(550, 600);
		//AND(550, 750);
	}

	// Runs each time the DOM window resize event fires.
	// Resets the canvas dimensions to match window, then draws the canvas accordingly.
	function resizeCanvas() {
		htmlCanvas.width = window.innerWidth;
		htmlCanvas.height = window.innerHeight;
		redraw();
	}

	function link(FF_i, FF_N, sum, data){
		//J1=120 211 -> y2 * x' + y1 * x
		var str = data.split(' ');
		var i, j;
		var times = 0;
		var web_h = $(document).height();
		var web_w = $(document).width();
		var FF_x = web_w-500;
		console.log(FF_y);
		for(i = 0; i < str.length; i++){
			var FF_y = (FF_i/(parseInt(FF_N)+1))*web_h;
			for(j = 0; j < sum; j++){
				if(parseInt(str[i][j]) != 2){
					var move_x = (parseInt(str[i][j]) == 1)? 0:1;
					var move_y = (i == 0)? -30:0;
					//console.log('FF_i = '+FF_i+' times = '+times+' i = '+i+' j= '+j);
					line_xxyy(10+10*((sum-j-1)*2+move_x), FF_y+move_y+10*(times), 200, FF_y+10*(times+2*i));
					times = times + 1;
				}
			}
		}
	}

	function leftLine(sum){
		var web_h = $(document).height();
		var web_w = $(document).width();
		var input_x = 10;
		var unit = 10;
		var i;
		for(i = 1; i <= 2*sum; i++){
			line_len(input_x+(i-1)*unit, 90, 0, 800);
		}
	}

	function rightLine(FF_N, input_N){
		var i;
		var web_h = $(document).height();
		var web_w = $(document).width();
		var FF_x = web_w-500;
		var width = 150;
		var height = 150;
		var input_x = 10;
		var unit = 30;

		var first_y = (1/(parseInt(FF_N)+1))*web_h;
		for(i = 1; i <= FF_N; i++){
			var origin_y = (i/(parseInt(FF_N)+1))*web_h;
			var x = FF_x+0.9*width;
			var y = origin_y-0.3*height;
			line_len(x, y, (i-1)*unit, 0);
			line_xxyy(x+(i-1)*unit, y, x+(i-1)*unit, 30+(FF_N-i)*0.5*unit);
			line_xxyy(x+(i-1)*unit, 30+(FF_N-i)*0.5*unit, 10+10*(2*input_N+2*(FF_N-i)), 30+(FF_N-i)*0.5*unit);
			line_xxyy(10+10*(2*input_N+2*(FF_N-i)), 30+(FF_N-i)*0.5*unit, 10+10*(2*input_N+2*(FF_N-i)), 90);
		}

	}

	function line_len(x, y, width, height){
		cxt.moveTo(x, y);
		cxt.lineTo(x+width, y+height);
		cxt.stroke();
	}

	function line_xxyy(x, y, xx, yy){
		cxt.moveTo(x, y);
		cxt.lineTo(xx, yy);
		cxt.stroke();
	}

	function FF(type, centerX, centerY, width, height){
		x = centerX - 0.5*width;
		y = centerY - 0.5*height;
		var margin = 10;
		cxt.font = "24px Consola";
		cxt.rect(x, y, width, height);
		if(type == 1)
			cxt.fillText('D', x+margin, y+0.25*height);
		else if(type == 2)
			cxt.fillText('T', x+margin, y+0.25*height);
		else if(type == 3){
			cxt.fillText('J', x+margin, y+0.25*height);
			cxt.fillText('K', x+margin, y+0.85*height);
			cxt.moveTo(x, y+0.8*height);
			cxt.lineTo(x-0.4*width, y+0.8*height);
		}
		else if(type == 4){
			cxt.fillText('R', x+margin, y+0.25*height);
			cxt.fillText('S', x+margin, y+0.85*height);
			cxt.moveTo(x, y+0.8*height);
			cxt.lineTo(x-0.4*width, y+0.8*height);
		}

		cxt.fillText('Q', x+width-3*margin, y+0.25*height);
		cxt.fillText('FF', x+0.425*width, y+0.55*height);
		cxt.fillText('—', x+width-3.25*margin, y+0.75*height);
		cxt.fillText('Q', x+width-3*margin, y+0.85*height);

		// CLK
		if(type == 1 || type == 2){
			line_len(x, y+0.7*height, 0.2*width, 0.1*height);
			line_len(x+0.2*width, y+0.8*height, -0.2*width, -0.1*height);
		}
		else{
			line_len(x, y+0.4*height, 0.2*width, 0.1*height);
			line_len(x+0.2*width, y+0.5*height, -0.2*width, 0.1*height);
		}

		line_len(x, y+0.2*height, -0.4*width, 0);
		line_len(x+width, y+0.2*height, 0.4*width, 0);
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

};

