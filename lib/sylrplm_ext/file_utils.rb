module FileUtils
  def self.sync_file file_in , file_out
    #if PlmServices.file_exists? file_out
    #	equal = FileUtils.compare_file file_in , file_out
    #else
    equal = false
    #end
    unless equal
      puts fname="#{__FILE__}: copy_file #{file_in} , #{file_out}"
      FileUtils.copy_file file_in , file_out
    end

  end
end