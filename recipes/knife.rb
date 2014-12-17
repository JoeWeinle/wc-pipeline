directory "#{node['jenkins']['master']['home']}/.chef" do
  owner node['jenkins']['master']['user']
  group node['jenkins']['master']['user']
  mode 0755
end

# cookbook_file "#{node['jenkins']['master']['home']}/.chef/pipeline.pem" do
#   source "pipeline.pem"
#   owner node['jenkins']['master']['user']
#   group node['jenkins']['master']['group']
#   mode 0644
#   action :create
# end
search(:chef_orgs, "*:*").each do |org|
  template "#{node['jenkins']['master']['home']}/.chef/knife.rb" do
    cookbook 'pipeline'
    source "knife.rb.erb"
    owner node['jenkins']['master']['user']
    group node['jenkins']['master']['group']
    mode 0644
    variables(
      :chef_server_url => org['chef_server_url'],
      :client_node_name => org['client']
    )
  end

  file "#{node['jenkins']['master']['home']}/.chef/#{org['client']}.pem" do
    content org['pem']
    owner node['jenkins']['master']['user']
    group node['jenkins']['master']['group']
    mode 0644
  end   
end