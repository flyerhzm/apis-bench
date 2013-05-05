configure :development do
  set :database, "mysql2://root@localhost/api_bench_development"
end

configure :test do
  set :database, "mysql2://root@localhost/api_bench_test"
end

configure :production do
  set :database, "mysql2://api-bench:api-bench@localhost/api_bench_production"
end
