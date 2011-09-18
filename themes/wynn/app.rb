module Nesta
  class App
    use Rack::Static, :urls => ['/wynn'], :root => 'themes/wynn/public'

    def speaker_deck_thumb_url(id)
      "//speakerd.s3.amazonaws.com/presentations/#{id}/thumb_slide_0.jpg"
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
end
