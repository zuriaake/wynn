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

    get '/articles.xml' do
      content_type :xml, :charset => 'utf-8'
      set_from_config(:title, :subtitle, :author)
      @articles = Page.find_articles.select { |a| a.date }[0..9]
      cache haml(:atom, :format => :xhtml, :layout => false)
    end

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

    def is_linked?
      not self.metadata('url').to_s.empty?
    end

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

    # def slug
    #   ret = self.metadata('slug') || self.heading
    #
    #   #strip the string
    #   ret = ret.strip
    #
    #   #blow away apostrophes
    #   ret.gsub! /['`]/,""
    #
    #   # @ --> at, and & --> and
    #   ret.gsub! /\s*@\s*/, " at "
    #   ret.gsub! /\s*&\s*/, " and "
    #
    #   #replace all non alphanumeric, underscore or periods with underscore
    #    ret.gsub! /\s*[^A-Za-z0-9\._]\s*/, '-'
    #
    #    #convert double underscores to single
    #    ret.gsub! /-+/,"-"
    #
    #    #strip off leading/trailing underscore
    #    ret.gsub! /\A[\-\.]+|[\-\.]+\z/,""
    #
    #    ret
    # end

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
