module FileUtils
	def self.sync_file file_in , file_out
  	unless FileUtils.compare_file file_in , file_out
  		puts fname="#{__FILE__}: copy_file #{file_in} , #{file_out}"
  		FileUtils.copy_file file_in , file_out
  	end
  end
end