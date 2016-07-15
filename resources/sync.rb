actions :sync
default_action :sync

attribute :source, kind_of: String
attribute :destination, kind_of: String, name_attribute: true
attribute :skip, kind_of: Array

action :sync do
    converge_by("sync from #{new_resource.source} to #{new_resource.destination}") do
        sync_dirs(new_resource.source, new_resource.destination, new_resource.skip)
    end
end
