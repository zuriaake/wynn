class NestaController < ApplicationController
  include NestaHelper

  before_filter :set_common_variables, :only => [:show, :feed, :sitemap]
  before_filter :find_page, :only => :show
  before_filter :ensure_best_path, :only => :show

  def show
    if @page.nil?
      raise ActionController::RoutingError.new('Not Found')
    end
    set_from_page(:description, :keywords)
    @title = @page.title
    render :action => @page.template
  end

  def feed
    @articles = Nesta::Page.find_articles.select { |a| a.date }[0..9]
    render :atom, :content_type => :xml, :layout => false
  end

  def sitemap
    @pages = Nesta::Page.find_all
    @last = @pages.map { |page| page.last_modified }.inject do |latest, page|
      (page > latest) ? page : latest
    end
    render :sitemap, :content_type => :xml, :layout => false
  end

  private

  def find_page
    @page ||= Nesta::Page.find_by_path(page_path)
  end

  def ensure_best_path
    if @page && !@page.best_path?(request.path)
      best_url = "#{request.protocol}#{request.host_with_port}#{@page.permalink}"
      redirect_to best_url, :status => 301
    end
  end

  def page_path
    path     = request.path
    segments = path.split('/')

    if segments[-2].to_s.match(Nesta::Plugin::Sluggable::SLUGGED_FORMAT)
      path = segments[0..-2].join('/')
    end

    path
  end
end
