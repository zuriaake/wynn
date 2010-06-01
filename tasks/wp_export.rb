QUERY = "select post_title, post_name, post_date, post_content, post_excerpt, ID, guid from wp_posts where post_status = 'publish' and post_type = 'post'"

db = Sequel.mysql('wynn', :user => 'root', :password => '', :host => 'localhost', :encoding => 'utf8')

db[QUERY].each do |post|
  # Get required fields and construct Jekyll compatible name
  title = post[:post_title]
  slug = post[:post_name]
  date = post[:post_date]
  content = post[:post_content]
  name = "#{slug}.mdown"

  # Get the relevant fields as a hash, delete empty fields and convert
  # to YAML for the header
  data = {
     'date' => post[:post_date],
     'summary' => post[:post_excerpt].to_s,
     'categories' => 'blog'
   }.delete_if { |k,v| v.nil? || v == ''}.to_yaml.gsub("--- \n", "")

  # Write out the data and content to file
  File.open("content/pages/#{name}", "w") do |f|
    f.puts data
    f.puts "\n"
    f.puts "# #{title}"
    f.puts content
  end
end
