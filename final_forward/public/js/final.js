function makeCircuit(){
	$.get('/makeCircuit',function(data){
		var arg = data.split('\n');
		doCanvas(arg);
	});
}

function remove(id) {
	var elem = document.getElementById(id);
	elem.parentNode.removeChild(elem);
	return false;
}

function createInput(){
	var inputN = $('input[name="inputN"]').val();
	var stateN = $('input[name="stateN"]').val();
	createInputType(stateN);
	createInputTable(stateN, inputN);
	remove("myfieldset");

}

function createInputType(stateN){

	var i, j;

	for(i = stateN; i > 0; i--){
		$( "<form>Type of FF for Q"+i+":"+"<input type='radio' name='type' checked> D <input type='radio' name='type'> T <input type='radio' name='type'> JK <input type='radio' name='type'> RS Flip Flop</form>").insertAfter( "#pp" );
	}

}

function createInputTable(data, data2){
	var stateN = parseInt(data);
	var inputN = parseInt(data2);
	var rowN = Math.pow(stateN+inputN, 2);
	var table = document.getElementById("myTable");
	var header = table.createTHead();
	var row;  
	var cell;
	var i, j;


	//tbody
	for(i = 0; i < rowN; i++){
		//tr
		bin = i.toString(2);
		row = table.insertRow(table.rows.length);
		for(j = 0; j < stateN+inputN; j++){
			//td
			cell = row.insertCell(0);		//insert from front
			cell.innerHTML = (j >= bin.length)? 0 : bin[j];
		}
		for(j = 0; j < stateN+1; j++){
			cell = row.insertCell(table.rows[i].cells.length);		//insert from front
			cell.innerHTML = "<input type='number' value='0' min='0' max='1'>";

			//document.body.appendChild(p);

		}
	}

	//thead
	row = header.insertRow(0);
	for(j = 1; j <= stateN; j++){
		cell = row.insertCell(table.rows[0].cells.length);	//insert from back
		cell.innerHTML = 'Q'+j;
	}
	for(j = 1; j <= inputN; j++){
		cell = row.insertCell(table.rows[0].cells.length);	//insert from back
		cell.innerHTML = 'X'+j;
	}
	for(j = 1; j <= stateN; j++){
		cell = row.insertCell(table.rows[0].cells.length);	//insert from back
		cell.innerHTML = 'Q'+j+'+';
	}
	cell = row.insertCell(table.rows[0].cells.length);	//insert from back
	cell.innerHTML = 'Z';
}

function doCanvas(arg) {
	// Obtain a reference to the canvas element using its id.
	var htmlCanvas = document.getElementById('c'),

		// Obtain a graphics ctx on the  canvas element for drawing.
		ctx = htmlCanvas.getContext('2d');
	fitToContainer(htmlCanvas);

	// Start listening to resize events and draw canvas.
	initialize();

	function fitToContainer(canvas){
		canvas.style.width='100%';
		canvas.style.height='100%';
		canvas.width  = canvas.offsetWidth;
		canvas.height = canvas.offsetHeight;
	}

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
		arg = [1, 1, 3, "110 101 111", "111", 4, "210", "200", 1, "000"];
		var FF_N = parseInt(arg[0]);
		var input_N = parseInt(arg[1]);
		var FF_type = [];
		var i;
		var tmp = 3;
		var exp = [];
		var output_exp = arg[2];

		for(i = 0; i < FF_N; i++){
			FF_type.push(parseInt(arg[tmp]));
			if(parseInt(arg[tmp]) <= 2){
				exp.push(arg[tmp+1]);
				tmp += 2;
			}else{
				exp.push(arg[tmp+1]);
				exp.push(arg[tmp+2]);
				tmp += 3;
			}
		}

		var web_h = $(document).height();
		var web_w = $(document).width();
		var FF_x = web_w-500;
		var i;

		ctx.scale(1/1.8, 1/1.8);

		leftLine(input_N, input_N+FF_N);
		rightLine(FF_N, input_N);

		var tmp2 = 0;
		for(i = 0; i < FF_type.length; i++){
			if(FF_N == 1){
				FF(FF_type[i], FF_x, web_h, 150, 150);
			}
			else if(FF_N <= 2){
				FF(FF_type[i], FF_x, ((i+1)/(FF_N+1))*(web_h*2), 150, 150);
			}
			else if(FF_N >= 3){
				FF(FF_type[i], FF_x, 300+(i/(FF_N-1))*((web_h-100)*1.8), 150, 150);
			}

			if(FF_type[i] <= 2){
				link(i+1, -1, FF_N, input_N+FF_N, exp[tmp2]);
				tmp2++;
			}

			else if(FF_type[i] >= 3){
				link(i+1, -1, FF_N, input_N+FF_N, exp[tmp2]);
				link(i+1, 1, FF_N, input_N+FF_N, exp[tmp2+1]);
				tmp2 += 2;
			}
		}

	}

	// Runs each time the DOM window resize event fires.
	// Resets the canvas dimensions to match window, then draws the canvas accordingly.
	function resizeCanvas() {
		htmlCanvas.width = window.innerWidth;
		htmlCanvas.height = 2*window.innerHeight;
		redraw();
	}

	function link(FF_i, u_d, FF_N, sum, data){
		//J1=120 211 -> y2 * x' + y1 * x
		var str = data.split(' ');
		var i, j;
		var web_h = $(document).height();
		var web_w = $(document).width();
		var FF_x = web_w-500;
		var FF_y; 
		if(FF_N == 1){
			FF_y = web_h;
		}
		else if(FF_N <= 2){
			FF_y = ((i+1)/(FF_N+1))*(web_h*2);
		}
		else if(FF_N >= 3){
			FF_y = 300+(i/(FF_N-1))*((web_h-100)*1.8);
		}
		var and_w = 50;
		var and_h = 50*(times/2);
		var hh = [];
		var and_x;
		for(i = 0; i < str.length; i++){
			var times = 0;
			var move_y;
			if(u_d == -1){
				move_y = -170+150*i;
				and_x = 300;
			}else if(u_d == 1){
				move_y = 120+150*i;
				and_x = 650;
			}
			for(j = 0; j < sum; j++){
				if(parseInt(str[i][j]) != 2){
					var move_x = (parseInt(str[i][j]) == 1)? 0:1;
					var unit_l = 20;
					line_xxyy(10+unit_l*((sum-j-1)*2+move_x), FF_y+move_y+unit_l*(times), and_x, FF_y+move_y+unit_l*(times));
					times = times + 1;
				}
			}
			and_h = 40*(times/2);
			AND(and_x, FF_y+move_y+unit_l*(times-1)/2-and_h/2, and_w, and_h);
			hh.push(FF_y+move_y+unit_l*(times-1)/2);
		}
		var avg = 0;
		for(i = 0; i < hh.length; i++){
			avg += hh[i];
		}
		avg = avg / hh.length;
		var or_w = 80;
		var or_h = 150*str.length/1.5;
		var FF_w = 150;
		var FF_h = 150;
		OR(and_x+and_w+150, avg-or_h/2, or_w, or_h);
		line_xxyy(and_x+and_w+150+or_w+0.5*or_h, avg, FF_x-0.9*FF_w, avg);
		line_xxyy(FF_x-0.9*FF_w, avg, FF_x-0.9*FF_w, FF_y+u_d*0.3*FF_h);
	}

	function leftLine(input_N, sum){
		var web_h = $(document).height();
		var web_w = $(document).width();
		var input_x = 10;
		var unit = 20;
		var i;
		for(i = 1; i <= 2*sum; i++){
			if(i <= 2*input_N && i % 2 == 1){
				ctx.font = "18px Consola";
				ctx.fillText('X'+(i+1)/2, input_x+(i-1)*unit-10, 40);
				line_len(input_x+(i-1)*unit, 120-40, 0, 2500+40);
			}
			else{
				line_len(input_x+(i-1)*unit, 120, 0, 2500);
			}
			if(i % 2 == 1){
				NOT(input_x+(i-1)*unit, 120-5*2.732, 21);
			}
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
		var unit_r = 30;
		var unit_l = 20;

		for(i = 1; i <= FF_N; i++){
			var origin_y;
			if(FF_N == 1){
				origin_y = web_h;
			}
			else if(FF_N <= 2){
				origin_y = ((i+1)/(FF_N+1))*(web_h*2);
			}
			else if(FF_N >= 3){
				origin_y = 300+(i/(FF_N-1))*((web_h-100)*1.8);
			}
			var x = FF_x+0.9*width;
			var y = origin_y-0.3*height;
			line_len(x, y, (i-1)*unit_r, 0);
			line_xxyy(x+(i-1)*unit_r, y, x+(i-1)*unit_r, 30+(FF_N-i)*0.5*unit_r);
			line_xxyy(x+(i-1)*unit_r, 30+(FF_N-i)*0.5*unit_r, 10+unit_l*(2*input_N+2*(FF_N-i)), 30+(FF_N-i)*0.5*unit_r);
			line_xxyy(10+unit_l*(2*input_N+2*(FF_N-i)), 30+(FF_N-i)*0.5*unit_r, 10+unit_l*(2*input_N+2*(FF_N-i)), 120);
		}

	}

	function line_len(x, y, width, height){
		ctx.moveTo(x, y);
		ctx.lineTo(x+width, y+height);
		ctx.stroke();
	}

	function line_xxyy(x, y, xx, yy){
		ctx.moveTo(x, y);
		ctx.lineTo(xx, yy);
		ctx.stroke();
	}

	function FF(type, centerX, centerY, width, height){
		x = centerX - 0.5*width;
		y = centerY - 0.5*height;
		var margin = 10;
		ctx.font = "24px Consola";
		ctx.rect(x, y, width, height);
		if(type == 1)
			ctx.fillText('D', x+margin, y+0.25*height);
		else if(type == 2)
			ctx.fillText('T', x+margin, y+0.25*height);
		else if(type == 3){
			ctx.fillText('J', x+margin, y+0.25*height);
			ctx.fillText('K', x+margin, y+0.85*height);
			line_len(x-0.4*width, y+0.8*height, 0.4*width, 0);
		}
		else if(type == 4){
			ctx.fillText('R', x+margin, y+0.25*height);
			ctx.fillText('S', x+margin, y+0.85*height);
			line_len(x-0.4*width, y+0.8*height, 0.4*width, 0);
		}

		ctx.fillText('Q', x+width-3*margin, y+0.25*height);
		ctx.fillText('FF', x+0.425*width, y+0.55*height);
		ctx.fillText('—', x+width-3.25*margin, y+0.75*height);
		ctx.fillText('Q', x+width-3*margin, y+0.85*height);

		// CLK
		if(type == 1 || type == 2){
			line_len(x, y+0.7*height, 0.2*width, 0.1*height);
			line_len(x+0.2*width, y+0.8*height, -0.2*width, 0.1*height);
		}
		else{
			line_len(x, y+0.4*height, 0.2*width, 0.1*height);
			line_len(x+0.2*width, y+0.5*height, -0.2*width, 0.1*height);
		}

		line_len(x, y+0.2*height, -0.4*width, 0);
		line_len(x+width, y+0.2*height, 0.4*width, 0);
	}

	// Gates and FFs
	function NOT(x, y, unit){
		line_len(x, y, 0.7*unit, 0);
		line_len(x+0.45*unit, y-1.732/4*unit, unit, 0);
		line_len(x+0.45*unit, y-1.732/4*unit, 0.5*unit, 1.732/2*unit);
		line_len(x+1.45*unit, y-1.732/4*unit, -0.5*unit, 1.732/2*unit);
		var radius = unit / 8;
		ctx.moveTo(x+0.95*unit+radius, y+1.732/4*unit+radius);
		ctx.arc(x+0.95*unit,y+1.732/4*unit+radius,radius,0,2*Math.PI);
		ctx.stroke();
	}

	function AND(x, y, width, height){
		line_len(x, y, width, 0);
		ctx.moveTo(x+width, y);
		ctx.arc(x+width, y+0.5*height, 0.5*height, 1.5*Math.PI, 0.5*Math.PI);
		line_len(x, y+height, width, 0);
		line_len(x, y, 0, height);
		line_len(x+width+0.5*height, y+0.5*height, 150-0.5*height, 0);
		ctx.stroke();
	}

	function OR(x, y, width, height){
		line_len(x, y, width, 0);
		ctx.moveTo(x+width, y);
		ctx.arc(x+width, y+0.5*height, 0.5*height,1.5*Math.PI,0.5*Math.PI);
		ctx.moveTo(x, y);
		ctx.quadraticCurveTo(x+width, y+0.5*height, x, y+height);
		line_len(x, y+height, width, 0);
		ctx.stroke();
	}

};

