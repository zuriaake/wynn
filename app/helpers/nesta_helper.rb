module NestaHelper
  include Nesta::View::Helpers
  include Nesta::Navigation::Renderers

  # Override the equivalent method in Nesta::View::Helpers, which uses
  # Sinatra's `haml` method instead of `render`.
  def article_summaries(articles)
    render 'summaries', :pages => articles
  end

  # When used in Rails, Haml's &= markup won't escape the markup that
  # follows it if the string is already marked as safe. This is because
  # the Rails XSS code gets involved, and overrides the behaviour (i.e.
  # breaks) the behaviour of the API. We make a new (unsafe) string to
  # force it to behave itself.
  def permit_html_escape(string)
    String.new(string)
  end

  def related_articles(limit = 5)
    paths = [
      # "/journal/how-to-get-great-support",
      # "/journal/a-stylesheet-author-s-guide-to-terminal-colors",
      # "/journal/what-makes-a-good-api-wrapper",
      # "/journal/dotfiles-discovery",
      # "/journal/github-is-a-fish-bowl",
      # "/linked/2014010902",
      # "/journal/don-t-tell-me-how-fast-i-read",
      # "/journal/flint-lint-your-project-for-sources-of-contributor-friction",
      # "/journal/patches-speak-louder-than-words",
      # "/journal/putting-the-emote-in-remote-work",
      # "/journal/tmux-stateful-workspaces-for-frictionless-context-switching",
      # "/journal/i-love-the-smell-of-facepalm-in-the-morning"
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

  def image_for_page
    image_from_metadata || image_from_speakerdeck || image_from_youtube ||
      "http://cl.ly/image/430l0T1c1j11/wynn-moscow-square.png"
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
      :asset_root => "https://github.global.ssl.fastly.net/images/icons",
      :base_url   => "http://yountlabs.com",
      :gfm        => false
    }
    pipeline = HTML::Pipeline.new [
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::EmojiFilter
    ], context
    result = pipeline.call(text)

    result[:output].to_s
  end

  private

  def image_from_metadata
    @page && @page.metadata('image')
  end

  def image_from_speakerdeck
    if @page && speaker_deck_id = @page.metadata('speaker_deck_id')
      speaker_deck_thumb_url(speaker_deck_id)
    end
  end

  def image_from_youtube
    if @page && youtube = @page.metadata('youtube')
      "http://img.youtube.com/vi/#{youtube}/0.jpg"
    end
  end
end
