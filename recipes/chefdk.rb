filename = 'chefdk-0.3.2-1.x86_64.rpm'
download_path = "#{Chef::Config['file_cache_path']}"
 
remote_file "#{download_path}/#{filename}" do
  source 'https://opscode-omnibus-packages.s3.amazonaws.com/el/6/x86_64/chefdk-0.3.2-1.x86_64.rpm'
  mode '0644'
  checksum '62fc6db2e7c3467f26a090755af55c97'
end
 
rpm_package 'chefdk' do
  source "#{download_path}/#{filename}"
  action :install
end