Blog::Application.routes.draw do
  match 'articles.xml' => 'nesta#feed'
  match 'sitemap.xml' => 'nesta#sitemap'
  mount NestaController.action(:show), :at => '/'
end
