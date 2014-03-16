if Rails.env.production?
	Neo4j::Session.open(:server_db, ENV["GRAPHENEDB_URL"])
else 
	require 'yaml'
	path = Rails.root.join('config', 'graph_database.yml')
	graph_database = YAML.load_file(path)
	Neo4j::Session.open(:server_db, graph_database[Rails.env][:graph_url])
end