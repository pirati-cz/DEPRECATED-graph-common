var ConfigurationManager = require('./lib/configuration_manager');
var Graph = require('./lib/graph');

var cm = new ConfigurationManager({
	name: "Pirati Open Graph API",
	database: "mongodb://localhost/graph",
	route_manager: {
		"EchoRouter" : { name: "EchoRouter", require: "./echo_router" }
	},
	node_manager: { 
		"test1" : { name: "test1", router: 'EchoRouter' },
		"test2" : { name: "test2", router: 'EchoRouter' }
	}
});

var graph = new Graph(cm);

function display_object(data) {
	console.log(JSON.parse(data));
}

graph.run('test1 read { "name": "dummy1"}', display_object);
graph.run('test2 read { "name": "dummy2"}', display_object);
graph.run('test3 read { "name": "dummy3"}', display_object);
