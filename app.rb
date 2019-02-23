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
    @syllabuses = Syllabus.select("id, title, instructor, gakubu, gakka, week, koma, credit, category, elective").where('title LIKE ?', "%#{params[:title]}%").where('instructor LIKE ?', "%#{params[:instructor]}%").where('gakubu LIKE ?', "#{params[:gakubu]}%").where('gakka LIKE ?', "#{params[:gakka]}%").where('week LIKE ?', "#{params[:week]}%").where('koma LIKE ?', "#{params[:koma]}%")
    erb :list
end

get '/syllabus/:id' do |id|
    @syllabus = Syllabus.select("id, title, instructor, gakubu, gakka, week, koma, credit, category, elective").find(id)
    erb :syllabus
end