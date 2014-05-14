var graphlib = require('./')
var ConfigurationManager = graphlib.ConfigurationManager;
var Graph = graphlib.Graph;

mongo_host = process.env.DB_PORT_27017_TCP_ADDR || 'localhost';
mongo_port = process.env.DB_PORT_27017_TCP_PORT || '27017';
mongo_database = 'graph'
mongo_uri = "mongodb://"+mongo_host+":"+mongo_port+"/"+mongo_database

var cm = new ConfigurationManager({
  name: "Piráti Open Graph API",
  StorageManager: mongo_uri,
  logLevel: 'silly',
  logFile: 'logs/graph.log'
});

var gql_script = [
  '/',
  'echo read { "name": "dummy1"}',
  'echo/redirect read { "name": "dummy2"}',
  'chain read test',
  'node/?property=name&property=path&skip=0&limit=2&conditions={"name":"mirror"}&sort=-name read',
  'node/53673fac16c3f9ce329aa6c9 read'].join("\n");

function display_object(query) {
  try {
    console.log(JSON.parse(query.data));
  } catch (e) {
    console.log(query.data);
  }
}
var graph = new Graph(cm, function () {
  graph.run(gql_script, display_object);
});

setTimeout(function () {
  graph.disconnect();
}, 1000);
