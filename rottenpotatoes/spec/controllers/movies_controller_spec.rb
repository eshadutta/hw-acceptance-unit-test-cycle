require 'rails_helper'
describe MoviesController do
  describe 'Search movies by the same director' do
    it 'should call Movie.similar_movies' do
      expect(Movie).to receive(:similar_movies).with('Movie1')
      get :movie_with_same_director, { title: 'Movie1' }
    end

    it 'Need to assign similar movies if director exists' do
      movies = ['Movie2', 'Movie3']
      Movie.stub(:similar_movies).with('Movie2').and_return(movies)
      get :movie_with_same_director, { title: 'Movie2' }
      expect(assigns(:similar_movies)).to eql(movies)
    end

    it "should redirect to home page if director isn't known" do
      Movie.stub(:similar_movies).with('Movie3').and_return(nil)
      get :movie_with_same_director, { title: 'Movie3' }
      expect(response).to redirect_to(movies_path)
    end
 end

 describe 'Delete movie' do
    movie_params = {:title => 'random title', :director => 'random director', :rating => 'R', :description => 'random', :release_date => '17-Feb-1995'}
    let!(:movie) {Movie.create(movie_params)}

    it 'should set the flash' do
      delete :destroy, {id: movie.id}
      expect(flash[:notice]).to match(/deleted/)
      expect(response).to redirect_to(movies_path)
    end
  end

 describe 'Create Movie' do
    movie_params = {:title => 'random title', :director => 'random director', :rating => 'R', :description => 'random', :release_date => '17-Feb-1995'}
    let!(:movie) {Movie.create(movie_params)}

    it 'should create a movie' do
      expect(Movie).to receive(:create!).with(movie_params).and_return(movie)
      post :create, movie: movie_params
      expect(flash[:notice]).to match(/was successfully created/)
      expect(response).to redirect_to(movies_path)
    end
  end

 describe 'Get Index' do
    it 'should get index' do
      get :index
      expect(response).to render_template('index')
    end
  end

 describe 'Show Movie' do
    let!(:movie) { Movie.create({:title => 'Blade Runner', :director => 'Ridley Scott'})}

    it 'should get movie details page' do
      get :show, id: movie.id
      expect(response).to render_template('show')
    end
  end

 describe 'Edit Movie' do
    let!(:movie) { Movie.create({:title => 'Blade Runner', :director => 'Ridley Scott'})}

    it 'should get edit page for movie' do
      get :edit, id: movie.id
      expect(response).to render_template('edit')
    end
  end

 describe 'Update Movie' do
    let!(:movie) { Movie.create({:title => 'Blade Runner', :director => 'Ridley Scott'})}

    it 'should update the details' do
      put :update, {id: movie.id, :movie => {'director' => 'another name'}}
      expect(flash[:notice]).to match(/was successfully updated/)
      expect(response).to redirect_to(movie_path)
    end
  end

 describe 'sort functionality testing' do
    it 'should title sort the movies' do
      get :index, {sort: 'title'}
      order = Movie.order(:title)
      expect(order).to eq(order.sort)
      expect(assigns(:title_header)).to match(/hilite/)
      expect(response).to redirect_to movies_path(sort: :title, ratings: session[:ratings])
    end

    it 'should date sort the movies' do
      get :index, {sort: 'release_date'}
      order = Movie.order(:release_date)
      expect(order).to eq(order.sort)
      expect(assigns(:date_header)).to match(/hilite/)
      expect(response).to redirect_to movies_path(sort: :release_date, ratings: session[:ratings])
    end
  end
end
