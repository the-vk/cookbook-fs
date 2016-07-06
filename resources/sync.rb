actions :sync
default_action :sync

attribute :source, kind_of: String
attribute :destination, kind_of: String, name_attribute: true
