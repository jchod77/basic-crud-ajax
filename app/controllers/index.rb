# GET ========================================================

get '/' do
  @contacts = Contact.order('last_name ASC')
  erb :index
end

get '/contacts/new' do
  erb :new, layout: !request.xhr?
end

get '/contacts/:id' do
  @contact = Contact.find(params[:id])
  erb :show
end

get '/contacts/:id/edit' do
  @contact = Contact.find(params[:id])
  erb :edit
end

# POST ========================================================

post '/contacts' do
  @contact = Contact.create(params[:contact])
  if @contact.valid?
    if request.xhr?
      erb :_contact_row, layout: false, locals: { contact: @contact }
    else
      redirect to('/')
    end
  else
    erb :new
  end
end

post '/contacts/:id' do
  @contact = Contact.find(params[:id])
  if @contact.update_attributes(params[:contact])
    redirect to ('/')
  else
    erb :edit
  end
end

post '/contacts/:id/delete' do
  @contact = Contact.find(params[:id])
  @contact.destroy
  redirect to ('/')
end
