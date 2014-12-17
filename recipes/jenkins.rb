include_recipe "java"
include_recipe "jenkins::master"

jenkins_command 'safe-restart' do
  action :nothing
end

template "#{node['jenkins']['master']['home']}/proxy.xml" do
  source "proxy.xml.erb"
  owner node['jenkins']['master']['user']
  group node['jenkins']['master']['group']
  mode 0644
  variables(
    :proxy => node['wc-pipeline']['proxy']['https'],
    :port => node['wc-pipeline']['proxy']['port']
  )
  notifies :execute, "jenkins_command[safe-restart]", :immediately
end

node['wc-pipeline']['jenkins']['plugins'].each do |p|
  jenkins_plugin p do
    action :install
    notifies :execute, "jenkins_command[safe-restart]", :delayed
  end
end

# Setup berkshelf config to ignore SSL certificate errors
directory "#{node['jenkins']['master']['home']}/.berkshelf" do
  owner 'jenkins'
  group 'jenkins'
  recursive true
end

file "#{node['jenkins']['master']['home']}/.berkshelf/config.json" do
   content <<-EOD
   {"ssl":{"verify": false }}
   EOD
   owner node['jenkins']['master']['user']
end

#
# Install git
#

include_recipe "git::source"

file "/usr/bin/git" do
  action :delete
end

link "/usr/bin/git" do
  to "/usr/local/bin/git"
end

file "#{node['jenkins']['master']['home']}/.gitconfig" do
   content <<-EOD
  [http]
        sslVerify = false 
   EOD
   owner node['jenkins']['master']['user']
end

sudo 'jenkins' do
  user      "jenkins"
  nopasswd  true
  commands  ['/usr/bin/chef-client']
end