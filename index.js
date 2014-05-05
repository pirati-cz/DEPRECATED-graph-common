var ConfigurationManager = require('./lib/configuration_manager');
var Graph = require('./lib/graph');

mongo_host = process.env.DB_PORT_27017_TCP_ADDR || 'localhost';
mongo_port = process.env.DB_PORT_27017_TCP_PORT || '27017';
mongo_database = 'graph'
mongo_uri = "mongodb://"+mongo_host+":"+mongo_port+"/"+mongo_database

var cm = new ConfigurationManager({
  name: "Piráti Open Graph API",
  di: {
    StorageManager: './storage_manager',
    SchemaManager: './schema_manager',
    NodeManager: './node_manager',
    RouterManager: './router_manager',
    GQL: './gql'
  },
  SchemaManager: {
    "Schema": "./schema_schema",
    "Node": "./node_schema",
    "Router": "./router_schema"
  },
  StorageManager: mongo_uri,
  NodeManager: {
    "": { name: "root", path: "", router: 'EchoRouter' },
    "echo": { name: "echo", path: "echo", router: 'EchoRouter' },
    "echo/redirect": { name: "redirect", path: "echo/redirect", router: 'RedirectRouter', configuration: { redirect: "echo" } },
    "node": { name: "node", path: "node", router: 'StorageRouter', configuration: { schema: "Node" } }
  },
  RouterManager: {
    "EchoRouter": { name: "EchoRouter", require: "./echo_router" },
    "RedirectRouter": { name: "RedirectRouter", require: "./redirect_router" },
    "StorageRouter": { name: "StorageRouter", require: "./storage_router" }
  },
});

var gql_script = [
	'echo read { "name": "dummy1"}',
	'echo/redirect read { "name": "dummy2"}',
//  'node create { "name": "mirror", "path": "mirror", "router": "StorageRouter", "configuration": { "schema": "Node" } }',
  'mirror read'].join("\n");

function display_object(query) {
  if (typeof (query.data) === 'string') {
    console.log(JSON.parse(query.data));
    return;
  }
  console.log(query.data);
}
var graph = new Graph(cm, function () {
  graph.run(gql_script, display_object);
});

setTimeout(function () {
  graph.disconnect();
}, 1000);
