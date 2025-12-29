require 'net/http'
require 'json'
require 'jwt'

puts "=" * 50
puts "FINAL API VERIFICATION"
puts "=" * 50

def test_endpoint(method, path, headers = {}, body = nil)
  uri = URI("http://localhost:3000#{path}")
  
  case method.upcase
  when 'GET'
    request = Net::HTTP::Get.new(uri)
  when 'POST'
    request = Net::HTTP::Post.new(uri)
    request.body = body.to_json if body
  end
  
  headers.each { |k, v| request[k] = v }
  request['Content-Type'] = 'application/json' if body
  
  response = Net::HTTP.start(uri.hostname, uri.port) do |http|
    http.request(request)
  end
  
  {
    status: response.code,
    body: response.body,
    success: response.code.to_i.between?(200, 299)
  }
rescue => e
  { status: 'ERROR', body: e.message, success: false }
end

# 1. Health check
puts "\n1. Health Check:"
health = test_endpoint('GET', '/up')
puts "   Status: #{health[:status]} #{health[:success] ? '✓' : '✗'}"

# 2. Get auth token
puts "\n2. Authentication:"
auth = test_endpoint('POST', '/users/sign_in', {}, {
  user: { email: 'test@example.com', password: 'password123' }
})

if auth[:success]
  token = JSON.parse(auth[:body])['token'] rescue nil
  puts "   Login: #{token ? '✓ Token received' : '✗ No token'}"
  
  if token
    # 3. Test authenticated endpoint
    puts "\n3. Authenticated API:"
    api = test_endpoint('GET', '/api/v1/code_submissions.json', {
      'Authorization' => "Bearer #{token}"
    })
    puts "   API Access: #{api[:status]} #{api[:success] ? '✓' : '✗'}"
    
    # 4. Create submission
    puts "\n4. Create Submission:"
    create = test_endpoint('POST', '/api/v1/code_submissions.json', {
      'Authorization' => "Bearer #{token}"
    }, {
      code_submission: {
        content: 'final test',
        language: 'typescript'
      }
    })
    puts "   Creation: #{create[:status]} #{create[:success] ? '✓' : '✗'}"
  end
else
  puts "   Login failed: #{auth[:status]}"
end

# 5. Database check
puts "\n5. Database:"
begin
  user_count = User.count
  sub_count = CodeSubmission.count
  puts "   Users: #{user_count} ✓"
  puts "   Submissions: #{sub_count} ✓"
rescue => e
  puts "   Database error: #{e.message} ✗"
end

puts "\n" + "=" * 50
puts "VERIFICATION COMPLETE"
puts "=" * 50
