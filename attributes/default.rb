# set git version - added include recipe git::source to jenkins default
override['git']['version'] = '2.1.3'

# set jenkins plugins
default['aw-pipeline']['jenkins']['plugins'] = %w{ git git-client github-api github chef-identity }

# use chef-zero url for default
default['aw-pipeline']['chef_server']['url'] = "https://giscinchef.corporate.ge.com/organizations/avprod"
default['aw-pipeline']['chef_server']['node_name'] = "502282540"

# use example chef-repo and poll master branch every minute by default
# default['aw-pipeline']['chef-repo']['url'] = "https://github.sw.ge.com/AviationAppFactory/av-prod-chef-repo.git"
# default['aw-pipeline']['chef-repo']['branch'] = "*/master"
# default['aw-pipeline']['chef-repo']['polling'] = "* * * * *"

# set proxy for adding jenkins plugins
default['aw-pipeline']['proxy']['https'] = "sjc1intproxy01.crd.ge.com"
default['aw-pipeline']['proxy']['port'] = "8080"

# Github
default['aw-pipeline']['github']['server'] = "github.sw.ge.com"

# Set desired version of java
default['java']['jdk_version'] = '7'