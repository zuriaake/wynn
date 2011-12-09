require 'sinatra/content_for'

Tilt.prefer Tilt::RedcarpetTemplate

module Nesta
  class App
    helpers Sinatra::ContentFor

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

    # override to point to shared/
    def article_summaries(articles)
      haml(:"shared/summaries", :layout => false, :locals => { :pages => articles })
    end

  end

end
