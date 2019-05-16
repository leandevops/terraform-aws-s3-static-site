require 'awspec'
require 'parseconfig'

fixtures_file = 'tests/fixtures/tf_module/testing.tfvars'
tfvars_config = ParseConfig.new(fixtures_file)

# bucket
bucket_name = tfvars_config['domain_name']
tag_name = bucket_name
tag_env = tfvars_config['environment']
tag_built = tfvars_config['builtWith']

describe s3_bucket(bucket_name) do
  it { should exist }
end

describe s3_bucket(bucket_name) do
  it { should have_object('index.html') }
  it { should have_object('error.html') }
end

describe s3_bucket(bucket_name) do
  it { should have_tag('Name').value(tag_name) }
  it { should have_tag('environment').value(tag_env) }
  it { should have_tag('builtWith').value(tag_built) }
end

describe s3_bucket(bucket_name) do
  it do
    should have_policy <<-POLICY
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Sid": "PublicRead",
          "Effect": "Allow",
          "Principal": {
              "AWS": "*"
          },
          "Action": "s3:GetObject",
          "Resource": "arn:aws:s3:::#{bucket_name}/*"
      }
  ]
}
    POLICY
  end
end
