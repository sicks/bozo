RSpec::Matchers.define :match_json_schema do |schema, data, options = {}|
  schema_dir = "#{Dir.pwd}/spec/support/schemas"
  schema_path = "#{schema_dir}/#{schema}.json"
  JSON::Validator.validate!(schema_path, data, options)
end
