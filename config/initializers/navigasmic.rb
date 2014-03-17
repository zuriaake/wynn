Navigasmic.setup do |config|
  config.semantic_navigation :primary do |n|
    n.item 'Journal', '/'
    n.item 'Archives', '/archives'
    n.item 'About', '/about'
    # n.item 'Talks', '/talks'
  end
end
