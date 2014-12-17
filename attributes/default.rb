# set git version - added include recipe git::source to jenkins default
override['git']['version'] = '2.1.3'

# set jenkins plugins
default['wc-pipeline']['jenkins']['plugins'] = %w{ git git-client github-api github chef-identity }

# use chef-zero url for default
default['wc-pipeline']['chef_server']['url'] = "https://mychef.myco.com/organizations/test"
default['wc-pipeline']['chef_server']['node_name'] = "timmy"

# use example chef-repo and poll master branch every minute by default
# default['wc-pipeline']['chef-repo']['url'] = "https://github.sw.ge.com/AviationAppFactory/av-prod-chef-repo.git"
# default['wc-pipeline']['chef-repo']['branch'] = "*/master"
# default['wc-pipeline']['chef-repo']['polling'] = "* * * * *"

# set proxy for adding jenkins plugins
default['wc-pipeline']['proxy']['https'] = "moproxy.myco.com"
default['wc-pipeline']['proxy']['port'] = "8080"

# Github
default['wc-pipeline']['github']['server'] = "www.github.com"

# Set desired version of java
default['java']['jdk_version'] = '7'