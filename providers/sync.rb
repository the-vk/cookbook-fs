action :sync do
	sync_dirs(new_resource.source, new_resource.destination)
	new_resource.updated_by_last_action(true)
end

