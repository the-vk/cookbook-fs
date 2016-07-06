def sync_dirs(src, dst)
	src_entries = list(src).map{ |e| e.slice(src.length+1, e.length - (src.length + 1)) }
	dst_entries = list(dst).map{ |e| e.slice(dst.length+1, e.length - (dst.length + 1)) }

	entries_to_add = src_entries - dst_entries
	entries_to_del = dst_entries - src_entries
	entries_to_upd = src_entries - entries_to_add - entries_to_del

	entries_to_add.each do |entry|
		puts "Copy file #{File.join(src, entry)} to #{File.join(dst, entry)}"
		FileUtils.mkdir_p(File.join(dst, File.dirname(entry)))
		FileUtils.cp(File.join(src, entry), File.join(dst, entry), :preserve => true)
	end
	entries_to_del.each do |entry|
		puts "Delete file #{File.join(dst, entry)}"
		FileUtils.rm(File.join(dst, entry))
	end
	entries_to_upd.each do |entry|
		src_entry = File.join(src, entry)
		dst_entry = File.join(dst, entry)
		next if File.mtime(src_entry) == File.mtime(dst_entry)
		puts "Overwrite from #{src_entry} to #{dst_entry}"
		FileUtils.cp src_entry, dst_entry, :preserve => true
	end
end

def list(path)
	result = []
	entries = Dir.entries(path)
	entries.each do |entry|
		next if (entry == "." or entry == "..")
		entry = File.join(path, entry)
		if (Dir.exists? (entry))
			result = result.concat(list(entry))
		else
			result.push(entry)
		end
	end
	return result
end
