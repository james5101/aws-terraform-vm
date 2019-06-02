# encoding: utf-8
# copyright: 2018, The Authors

title 'Describe VM'
vm_name = "jamestest"

describe aws_ec2_instance("i-00f15a5c34a317ba1") do
  it { should exist }
end


describe aws_ec2_instance(name: vm_name) do
  it { should be_running }
end
