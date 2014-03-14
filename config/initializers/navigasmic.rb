Navigasmic.setup do |config|
  config.semantic_navigation :primary do |n|
    n.item 'Journal', '/', :highlights_on => /journal|linked|til/i
    n.item 'Archives', '/archives'
    n.item 'About', '/about'
    # n.item 'Books', '/books'
    # n.item 'Talks', '/talks'
  end
end
