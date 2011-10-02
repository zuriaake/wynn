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

    not_found do
      set_common_variables
      haml(:not_found, :layout => :centered)
    end

    error do
      set_common_variables
      haml(:error, :layout => :centered)
    end unless Nesta::App.development?


  end

  class FileModel


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


  module Plugin
    module IndexTank
      def self.api_url
        @api_url ||= ENV['INDEXTANK_API_URL']
      end

      def self.api_url=(url)
        @api_url = url
      end

      def self.index_name
        @index_name ||= 'idx'
      end

      def self.index_name=(name)
        @index_name = name
      end

      def self.client
        ::IndexTank::Client.new(self.api_url)
      end

      def self.index
        self.client.indexes(self.index_name)
      end

      def self.search(query, options={})
        results = Hashie::Mash.new(self.index.search(query, options))

        results.results.each do |r|
          r.page = Page.find_by_path(r.delete('docid'))
        end

        results
      end

    end
  end
end
