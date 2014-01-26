require 'html/pipeline'
require 'sinatra/simple-navigation'

module Nesta
  class App
    helpers ::SimpleNavigation::Helpers
    SimpleNavigation.config_file_path = File.join('config')

    set :views, 'views'
    set :cache, Dalli::Client.new

    def related_articles(limit = 5)
      paths = [
        "/journal/how-to-get-great-support",
        "/journal/a-stylesheet-author-s-guide-to-terminal-colors",
        "/journal/greenest-github-contributions-profiles",
        "/journal/what-makes-a-good-api-wrapper",
        "/journal/dotfiles-discovery",
        "/journal/octopress-classic-is-the-new-kubrick",
        "/journal/github-is-a-fish-bowl",
        "/linked/2014010902",
        "/journal/don-t-tell-me-how-fast-i-read",
        "/journal/flint-lint-your-project-for-sources-of-contributor-friction"
      ]

      paths.map {|p| Nesta::Page.find_by_path(p) }.
        shuffle[0..limit]
    end

    def url_or_permalink_for(page)
      page.is_linked? ? page.metadata('url') : page.permalink
    end

    def speaker_deck_thumb_url(id)
      "//speakerd.s3.amazonaws.com/presentations/#{id}/thumb_slide_0.jpg"
    end

    def css_classes_for(page)
      classes = page.metadata('tags').to_s.split(",")
      classes << 'linked-item' if page.is_linked?
      categories = page.metadata('categories').to_s.split(',')
      classes.
        concat(categories).
        map{|c| c.strip.downcase}.
        uniq.join(' ')
    end

    def widont(text)
      text.gsub(/([^\s])\s+([^\s]+)\s*$/, '\1&nbsp;\2')
    end

    def pipeline(text)
      context = {
        :asset_root => "http://#{request.host_with_port}/images",
        :base_url   => "http://wynnnetherland.com"
      }
      pipeline = HTML::Pipeline.new [
        HTML::Pipeline::MentionFilter,
        HTML::Pipeline::EmojiFilter
      ], context
      result = pipeline.call(text)

      result[:output].to_s
    end
  end
end
