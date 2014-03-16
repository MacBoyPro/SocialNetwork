if Rails.env.production?
	Neo4j::Session.open(:server_db, ENV["GRAPHENEDB_URL"])
else
	Neo4j::Session.open(:server_db, "http://localhost:7474")
end