SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.dom_class = 'site-nav'
    primary.item :journal, 'Journal', '/', :highlights_on => /^journal|linked|til/
    primary.item :archives, 'Archives', '/archives'
    primary.item :about, 'About', '/about'
    primary.item :books, 'Books', '/books'
    primary.item :talks, 'Talks', '/talks'
  end
end
