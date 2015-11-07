ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require './app/data_mapper_setup.rb'

class BookmarkManager < Sinatra::Base

  enable :sessions
  set :session_secret, 'secret'


  get '/' do
    erb(:index)
  end

  get '/users/new' do
    erb(:'users/new')
  end

  post '/users' do
    user = User.create(email: params[:email],
                     password: params[:password],
                     password_confirmation: params[:password_confirmation])

    session[:user_id] = user.id
    redirect('/links')
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

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  run! if app_file == $0
end
