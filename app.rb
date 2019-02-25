require 'sinatra'
require 'sinatra/reloader'
require 'active_record'

ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: './syllabuses.db'
)

class Syllabus < ActiveRecord::Base
end

helpers do
    def link_to(txt=url, url)
        %Q(<a href="#{url}">#{txt}</a>)
    end
end

get '/' do
    erb :index
end

post '/search' do
    @syllabuses = Syllabus.all.where('title LIKE ? and instructor LIKE ? and gakubu LIKE ? and gakka LIKE ? and week LIKE ? and koma LIKE ?', "%#{params[:title]}%", "%#{params[:instructor]}%", "#{params[:gakubu]}%", "#{params[:gakka]}%", "#{params[:week]}%", "#{params[:koma]}%")
    erb :list
end

get '/syllabus/:id' do |id|
    @syllabus = Syllabus.all.find(id)
    erb :syllabus
end