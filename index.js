var ConfigurationManager = require('./lib/configuration_manager');
var Graph = require('./lib/graph');

var cm = new ConfigurationManager({
  name: "Piráti Open Graph API",
  di: {
    Storage: './storage',
    NodeManager: './node_manager',
    RouteManager: './route_manager',
    GQL: './gql'
  },
  Storage: "mongodb://localhost/graph",
  NodeManager: { 
    "test1" : { name: "test1", router: 'EchoRouter' },
    "test2" : { name: "test2", router: 'RedirectRouter', options: { redirect: "test1" } }
  },
  RouteManager: {
    "EchoRouter" : { name: "EchoRouter", require: "./echo_router" },
    "RedirectRouter" : { name: "RedirectRouter", require: "./redirect_router" }
  },
});

var graph = new Graph(cm);

function display_object(object) {
  console.log(JSON.parse(object.data));
}

var gql_script = [
	'test1 read { "name": "dummy1"}',
	'test2 read { "name": "dummy2"}',
	'test3 read { "name": "dummy3"}'].join("\n");

graph.run(gql_script,	display_object);
