require 'awspec'
require 'parseconfig'

fixtures_file = 'tests/fixtures/tf_module/testing.tfvars'
tf_state_file = 'terraform.tfstate'

tfvars_config = ParseConfig.new(fixtures_file)
tf_state = JSON.parse(File.open(tf_state_file).read)

# describe s3_bucket('my-bucket') do
#   it { should exist }
# end

# describe s3_bucket('my-bucket') do
#   it { should have_object('path/to/object') }
# end

# describe s3_bucket('my-bucket') do
#   it do
#     should have_policy <<-POLICY
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Sid": "AllowPublicRead",
#       "Effect": "Allow",
#       "Principal": "*",
#       "Action": "s3:GetObject",
#       "Resource": "arn:aws:s3:::my-bucket/*"
#     }
#   ]
# }
#     POLICY
#   end
# end

# describe s3_bucket('my-bucket') do
#   it { should have_tag('env').value('dev') }
# end