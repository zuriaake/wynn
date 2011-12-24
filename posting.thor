require 'active_support/inflector'

class Post < Thor

  default_task :create

  desc "create", "create a new post"
  method_option :title, :aliases => "-t", :desc => "The title for the post"
  method_option :url, :aliases => "-u", :desc => "The URL for the link post"
  method_option :draft, :aliaes => "-d", :desc => "Flag post as draft", :type => :boolean
  def create
    categories = options.categories
    categories ||= options.url? ? 'linked' : 'journal'

    metadata = {
      :date => Time.now.to_s,
      :categories => categories
    }
    metadata[:url] = options.url if options.url?
    metadata[:flags] = 'draft' if options.draft?

    if options.url? or options.title.nil?
      date_string = Date.today.strftime('%Y%m%d')
      path = "content/pages/linked/#{date_string}"
      daily_count = Dir.glob("#{path}*").size + 1
      filename = path + daily_count.to_s.rjust(2, "0")
    else
      path = "content/pages/journal"
      filename = File.join(path, options.title.parameterize)
    end

    save_file(filename, metadata, options.title)
    system "$EDITOR #{filename}.mdown"
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
