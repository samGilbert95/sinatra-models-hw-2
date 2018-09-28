class App < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end

  #Setting the root as the parent directory of the current directory
  set :root, File.join(File.dirname(__FILE__),'..')
  # sets the view directory correctly
  set :views, Proc.new{File.join(root,"views")}
  # Creates array
  # $music = [
  #   {
  #     :id => 1,
  #     :track => "Last Surprise",
  #     :artist => "Shoji Meguro",
  #     :game => "Persona 5",
  #     :release => "2016",
  #   },
  #   {
  #     :id => 2,
  #     :track => "Condemned Tower",
  #     :artist => "Michiru Yamane",
  #     :game => "Castlevania: Dawn of Sorrow",
  #     :release => "2005",
  #
  #   },
  #   {
  #     :id => 3,
  #     :track => "Jump Up, Super Star",
  #     :artist => "Koji Kondo",
  #     :game => "Super Mario Odyssey",
  #     :release => "2018",
  #   }
  # ]

  #=== INDEX ===
  get '/music' do
    # defines local var music
    @music = Person.all
    # calls index.erb
    erb :'music/index'
  end
  #=== NEW ===
  get '/music/new' do
    # calls new.erb
    erb :'music/new'
  end
  #=== SHOW ===
  get '/music/:id' do
    # gets id of value
    id = params[:id].to_i
    # defines local var music
    @music = Person.find id
    # calls display.erb
    erb :'music/display'
  end

  #=== EDIT ===
  get '/music/:id/edit' do
    # gets id of value
    id = params[:id].to_i
    # defines local var music
    @music = Person.find id
    # calls edit.erb
    erb :'music/edit'
  end

  #=== CREATE ===
  post '/music' do
  # creates id var
  music = Person.new
  #sets values for new track hash to values from new.erb
  music.first_name = params[:first_name]
  music.last_name = params[:last_name]
  music.email = params[:email]
  music.gender = params[:gender]
  music.ip_address = params[:ip_address]
  # pushes new hash into global var music
  music.save
  # redirects page to index page
  redirect '/music'
  end
  #=== UPDATE ===
  put '/music/:id' do
    # creates music var
    id = (params[:id].to_i)
    music = Person.find id
    # changes values of track with those from edit.erb
    music.first_name = params[:first_name]
    music.last_name = params[:last_name]
    music.email = params[:email]
    music.gender = params[:gender]
    music.ip_address = params[:ip_address]
    # saves changes to global var music
    puts music.first_name
    music.save
    redirect '/music'
  end
  #=== DESTROY ===
  delete '/music/:id' do
    # creates id var
    id = params[:id].to_i
    # deletes item at array index value of id
    Person.destroy id
    redirect '/music'
  end

end

# edits to make:
# change intro page with images with a tag links
