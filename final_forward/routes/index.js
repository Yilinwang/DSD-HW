var express = require('express');
var router = express.Router();
var exec = require('child_process').exec;
var fs = require('fs');

/* GET home page. */
router.get('/', function(req, res, next) {
	res.render('index.ejs');
});

router.get('/makeCircuit', function(req, res){
	// execute forward_alg
	var child = exec('./forward_alg',  (error, stdout, stderr) => {
		if (error) {
			throw error;
		}
		console.log(stdout);

		//read output file
		fs.readFile('output_forwardAlg.txt', 'utf8', (err, data) => {
			if (err) throw err;
			res.end(data);
		});

	});
});

module.exports = router;
