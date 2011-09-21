module Nesta
  class App
    use Rack::Static, :urls => ['/wynn'], :root => 'themes/wynn/public'

    def speaker_deck_thumb_url(id)
      "//speakerd.s3.amazonaws.com/presentations/#{id}/thumb_slide_0.jpg"
    end

    def css_classes_for(page)
      tags = page.metadata('tags').to_s.split(",")
      categories = page.metadata('categories').to_s.split(',')
      classes = tags.concat(categories).map{|c| c.strip.downcase}.uniq.join(' ')
    end

    def url_for(page)
      url = page.metadata('url').to_s
      url = "#{base_url}/#{page.path}" if url.empty?

      url
    end

    not_found do
      set_common_variables
      haml(:not_found, :layout => :centered)
    end

    error do
      set_common_variables
      haml(:error, :layout => :centered)
    end unless Nesta::App.development?

    get '*' do
      set_common_variables
      @heading = @title
      parts = params[:splat].map { |p| p.sub(/\/$/, '') }

      # customization: check for ID in path
      if (segments = parts.first.split("/"))[-2].to_s[/\d{5}/]
        segments = [segments[0..-2].join("/")]
      end

      @page = Nesta::Page.find_by_path(File.join(segments))
      raise Sinatra::NotFound if @page.nil?

      # redirect to path with slug if has slug and slug not present
      redirect(@page.abspath, 301) unless @page.best_path?(parts.first)

      @title = @page.title
      set_from_page(:description, :keywords)
      cache haml(@page.template, :layout => @page.layout)
    end

  end

  class FileModel

    def slug
      self.metadata('slug')
    end

    def best_path?(path)
      path.gsub(/^\//, '') == self.abspath.gsub(/^\//,'')
    end

    def abspath
      page_path = @filename.sub(Nesta::Config.page_path, '')
      if index_page?
        File.dirname(page_path)
      else
        path = File.join(File.dirname(page_path), File.basename(page_path, '.*'))
        path += "/#{self.slug}" unless self.slug.to_s.empty?

        path
      end
    end

    private

      def convert_to_html(format, scope, text)
        case format
        when :mdown
          Redcarpet.new(text, :fenced_code).to_html
        when :haml
          Haml::Engine.new(text).to_html(scope)
        when :textile
          RedCloth.new(text).to_html
        end
      end

  end
end
