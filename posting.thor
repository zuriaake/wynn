class Post < Thor
  desc "link", "create a link post from a URL"
  def link(url)
    metadata = {
      :date => Date.today.to_s,
      :categories => "linked",
      :url => url
    }

    date_string = Date.today.strftime('%Y%m%d')
    path = "content/pages/linked/#{date_string}"
    daily_count = Dir.glob("#{path}*").size + 1

    filename = path + daily_count.to_s.rjust(2, "0")
    save_file(filename, metadata)

  end

  private

  def save_file(filename, metadata, heading=nil, body=nil)
    # Write out the data and content to file
    File.open("#{filename}.mdown", "w") do |f|
      puts "Saving #{filename}"
      metadata.each do |key, value|
        f.puts "#{key.to_s}: #{value}"
      end
      f.puts "\n"
      f.puts "# #{heading}" unless heading.nil?
      unless body.nil?
        f.puts "\n"
        f.puts body
      end
    end
  end

end
