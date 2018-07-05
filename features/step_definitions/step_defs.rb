def run_file
  puts "called...."
  exec( "ruby #{@file}")
end
Given("a file named {string}") do |string|
  @file = string
end

When("I successfully run ruby .\/blog.rb") do
  puts "here....."
  @response = run_file(@file)
  puts "@response : #{@response.inspect}"
end

Then("the output should contain") do |expected_answer|
  expect(@actual_answer).to include("Welcome to Zendesk Search")
end
