ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require './app/data_mapper_setup.rb'
require_relative 'models/link'

class BookmarkManager < Sinatra::Base
  get '/' do
    erb(:index)
  end

  get '/links' do
    @links = Link.all
    erb(:links)
  end

  get '/links/new' do
    erb(:'links/new_link')
  end

  get '/links/new' do
    erb(:'links/new_link')
  end

  post '/links/new/add' do
    Link.select {|link| @old_link = link if link.title == params[:title]}

    Tag.select {|tag| @old_tag = tag if tag.name == params[:name]}

    if @old_link != nil && @old_tag != nil
      (@old_link.tags << @old_tag).save
    elsif @old_link != nil && @old_tag == nil
      (@old_link.tags << Tag.create(name: params[:name])).save
    elsif @old_link == nil && @old_tag != nil
      new_link = Link.create(title: params[:title], url: params[:url])
      (new_link.tags << @old_tag).save
    else
        new_link = Link.create(title: params[:title], url: params[:url])
        (new_link.tags << Tag.create(name: params[:name])).save
    end
    redirect :links
  end

  get '/tags/:filter_by' do
    tag = Tag.first(name: params[:filter_by])
    @links = tag ? tag.links : []
    erb :tags
  end

  post '/tags' do
    @name = params[:name]
    redirect "/tags/#{@name}"
  end

  run! if app_file == $0
end





ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require './app/data_mapper_setup.rb'

require_relative 'models/link'


class BookmarkManager < Sinatra::Base
  get '/' do
    erb(:index)
  end

  get '/links' do
    @links = Link.all
    erb(:links)
  end

  get '/links/new' do
    erb(:'links/new_link')
  end


  post '/links/new/add' do
    Link.select {|link| @old_link = link if link.title == params[:title]}
    Tag.select {|tag| @old_tag = tag if tag.name == params[:name]}

    if @old_link != nil && @old_tag != nil
      (@old_link.tags << @old_tag).save
    elsif @old_link != nil && @old_tag == nil
      (@old_link.tags << Tag.create(name: params[:name])).save
    elsif @old_link == nil && @old_tag != nil
      new_link = Link.create(title: params[:title], url: params[:url])
      (new_link.tags << @old_tag).save
    else
        new_link = Link.create(title: params[:title], url: params[:url])
        (new_link.tags << Tag.create(name: params[:name])).save
    end
    redirect :links
  end

  # post '/links/new/add' do
  #   @tag = Tag.create(name: params[:name])
  #   Link.find do |link|
  #     if link.title == params[:title]
  #       @existing_link = link
  #     end
  #   end
  #   if @existing_link != nil
  #     @existing_link.tags << @tag
  #     @existing_link.save
  #   else
  #       new_link = Link.create(title: params[:title], url: params[:url])
  #       new_link.tags << @tag
  #       new_link.save
  #   end
  #
  #   redirect :links
  # end

  get '/tags/:filter_by' do
    tag = Tag.first(name: params[:filter_by])
    @links = tag ? tag.links : []
    erb :tags
  end

  post '/tags' do
    @name = params[:name]
    redirect "/tags/#{@name}"
  end

  run! if app_file == $0
end
