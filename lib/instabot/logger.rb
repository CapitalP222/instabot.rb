module Log

	def check_log_files
		puts "PROCESSING: ".cyan.bold + "checking log files"
		log("checking log files", "LOGGER")
		if !File.exists?(@logs_dir)
			Dir.mkdir(@logs_dir)
		end

		if options[:pre_load]
			if Dir.exists?('./logs')
				files = ['commented_medias', 'followed_users', 'liked_medias', 'unliked_medias', 'unfollowed_users']
				files.each do |file|
					File.open("./logs/#{file}.txt","r+") do |buffer|
						data = buffer.read.split(',')
						@local_stroage[file.to_sym] = data 
					end
				end
			end
		end
	end

	def write_file(filename, text="")
		File.open("#{@logs_dir}/#{filename}", "a+") {|file| file.print "#{text.chomp},"}
	end

	def log(text="",from="")
		time = Time.new.strftime("%H:%M:%S %y-%m-%d")
		if File.exists?(@logs_dir)
			File.open("#{@logs_dir}/logs-#{@global_time}.log","a+") do |log_file|
				log_file.puts "[#{@log_counter}] [#{time}] [#{from}] -- : #{text}"
			end
		else
			Dir.mkdir(@logs_dir)
		end
		@log_counter += 1
	end

	def save_action_data(id=0,type=:default)
		case type
		when :follow
			write_file("followed_users.txt",id)
		when :unfollow
			write_file("unfollowed_users.txt",id)
		when :like
			write_file("liked_medias.txt",id)
    when :unlike
      write_file("unliked_medias.txt",id)
		when :comment
			write_file("commented_medias.txt",id)
		when :default
			puts "please choose a type"
		else
			puts "please choose a type"
		end
	end

end	


