search(:chef_orgs, "*:*").each do |org|
  org['chef_repos'].each do |repo|

    xml = File.join(Chef::Config[:file_cache_path], "#{repo['name']}-config.xml")

    template xml do
      source "job-config.xml.erb"
       variables(
         :git_url => repo['url'],
         :build_command => '_knife_commands.sh.erb'
       )
    end

    # Create a jenkins job (default action is `:create`)
    jenkins_job "#{repo['name']}" do
      config xml
    end
  end
end